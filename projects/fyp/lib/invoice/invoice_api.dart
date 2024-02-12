// import 'dart:io';

// import 'package:fyp/invoice/pdf_api.dart';
// import 'package:fyp/invoice/utils.dart';
// import 'package:fyp/model/customer.dart';
// import 'package:fyp/model/invoice.dart';
// import 'package:fyp/model/supplier.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/widgets.dart';

// class PdfInvoiceApi {
//   static Future<File> generate(Invoice invoice) async {
//     final pdf = Document();

//     pdf.addPage(MultiPage(
//       // build: (ctx) => Center(child:Text("Somethng new"))
     
//       build: (context) => [
//         buildHeader(invoice),
//         SizedBox(height: 3 * PdfPageFormat.cm),
//         buildTitle(invoice),
//         buildInvoice(invoice),
//         Divider(),
//         buildTotal(invoice),
//       ],
//       footer: (context) => buildFooter(invoice),
//     ));
//     print(" PDF ==>"+pdf.document.versionString);
//     return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
//   }

//   static Widget buildHeader(Invoice invoice) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 1 * PdfPageFormat.cm),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               buildSupplierAddress(invoice.supplier),
//               Container(
//                 height: 50,
//                 width: 50,
//                 child: BarcodeWidget(
//                   barcode: Barcode.qrCode(),
//                   data: invoice.info.number,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 1 * PdfPageFormat.cm),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               buildCustomerAddress(invoice.customer),
//               buildInvoiceInfo(invoice.info),
//             ],
//           ),
//         ],
//       );

//   static Widget buildCustomerAddress(Customer customer) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(customer.name, style: TextStyle(fontWeight: FontWeight.bold)),
//           Text(customer.address),
//         ],
//       );

//   static Widget buildInvoiceInfo(InvoiceInfo info) {
//     final paymentTerms = '${info.dueDate.difference(info.date).inDays} days';
//     final titles = <String>[
//       'Invoice Number:',
//       'Invoice Date:',
//       'Payment Terms:',
//       'Due Date:'
//     ];
//     final data = <String>[
//       info.number,
//       Utils.formatDate(info.date),
//       paymentTerms,
//       Utils.formatDate(info.dueDate),
//     ];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: List.generate(titles.length, (index) {
//         final title = titles[index];
//         final value = data[index];

//         return buildText(title: title, value: value, width: 200);
//       }),
//     );
//   }

//   static Widget buildSupplierAddress(Supplier supplier) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold)),
//           SizedBox(height: 1 * PdfPageFormat.mm),
//           Text(supplier.address),
//         ],
//       );

//   static Widget buildTitle(Invoice invoice) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'INVOICE',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 0.8 * PdfPageFormat.cm),
//           Text(invoice.info.description),
//           SizedBox(height: 0.8 * PdfPageFormat.cm),
//         ],
//       );

//   static Widget buildInvoice(Invoice invoice) {
//     final headers = [
//       'Description',
//       'Date',
//       'Quantity',
//       'Unit Price',
//       'VAT',
//       'Total'
//     ];
//     final data = invoice.items.map((item) {
//       final total = item.unitPrice * item.quantity * (1 + item.vat);

//       return [
//         item.description,
//         Utils.formatDate(item.date),
//         '${item.quantity}',
//         '\$ ${item.unitPrice}',
//         '${item.vat} %',
//         '\$ ${total.toStringAsFixed(2)}',
//       ];
//     }).toList();

//     return Table.fromTextArray(
//       headers: headers,
//       data: data,
//       border: null,
//       headerStyle: TextStyle(fontWeight: FontWeight.bold),
//       headerDecoration: BoxDecoration(color: PdfColors.grey300),
//       cellHeight: 30,
//       cellAlignments: {
//         0: Alignment.centerLeft,
//         1: Alignment.centerRight,
//         2: Alignment.centerRight,
//         3: Alignment.centerRight,
//         4: Alignment.centerRight,
//         5: Alignment.centerRight,
//       },
//     );
//   }

//   static Widget buildTotal(Invoice invoice) {
//     final netTotal = invoice.items
//         .map((item) => item.unitPrice * item.quantity)
//         .reduce((item1, item2) => item1 + item2);
//     final vatPercent = invoice.items.first.vat;
//     final vat = netTotal * vatPercent;
//     final total = netTotal + vat;

//     return Container(
//       alignment: Alignment.centerRight,
//       child: Row(
//         children: [
//           Spacer(flex: 6),
//           Expanded(
//             flex: 4,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 buildText(
//                   title: 'Net total',
//                   value: Utils.formatPrice(netTotal),
//                   unite: true,
//                 ),
//                 buildText(
//                   title: 'Vat ${vatPercent * 100} %',
//                   value: Utils.formatPrice(vat),
//                   unite: true,
//                 ),
//                 Divider(),
//                 buildText(
//                   title: 'Total amount due',
//                   titleStyle: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   value: Utils.formatPrice(total),
//                   unite: true,
//                 ),
//                 SizedBox(height: 2 * PdfPageFormat.mm),
//                 Container(height: 1, color: PdfColors.grey400),
//                 SizedBox(height: 0.5 * PdfPageFormat.mm),
//                 Container(height: 1, color: PdfColors.grey400),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   static Widget buildFooter(Invoice invoice) => Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Divider(),
//           SizedBox(height: 2 * PdfPageFormat.mm),
//           buildSimpleText(title: 'Address', value: invoice.supplier.address),
//           SizedBox(height: 1 * PdfPageFormat.mm),
//           buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
//         ],
//       );

//   static buildSimpleText({
//     required String title,
//     required String value,
//   }) {
//     final style = TextStyle(fontWeight: FontWeight.bold);

//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: pw.CrossAxisAlignment.end,
//       children: [
//         Text(title, style: style),
//         SizedBox(width: 2 * PdfPageFormat.mm),
//         Text(value),
//       ],
//     );
//   }

//   static buildText({
//     required String title,
//     required String value,
//     double width = double.infinity,
//     TextStyle? titleStyle,
//     bool unite = false,
//   }) {
//     final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

//     return Container(
//       width: width,
//       child: Row(
//         children: [
//           Expanded(child: Text(title, style: style)),
//           Text(value, style: unite ? style : null),
//         ],
//       ),
//     );
//   }
// }
// import 'dart:io';

// import 'package:flutter/services.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

// import 'file_handle_api.dart';

// class PdfInvoiceApi {
//   static Future<File> generate() async {
//     final pdf = pw.Document();

//     final iconImage =
//         (await rootBundle.load('assets/icon.png')).buffer.asUint8List();

//     final tableHeaders = [
//       'Description',
//       'Quantity',
//       'Unit Price',
//       'VAT',
//       'Total',
//     ];

//     final tableData = [
//       [
//         'Coffee',
//         '7',
//         '\$ 5',
//         '1 %',
//         '\$ 35',
//       ],
//       [
//         'Blue Berries',
//         '5',
//         '\$ 10',
//         '2 %',
//         '\$ 50',
//       ],
//       [
//         'Water',
//         '1',
//         '\$ 3',
//         '1.5 %',
//         '\$ 3',
//       ],
//       [
//         'Apple',
//         '6',
//         '\$ 8',
//         '2 %',
//         '\$ 48',
//       ],
//       [
//         'Lunch',
//         '3',
//         '\$ 90',
//         '12 %',
//         '\$ 270',
//       ],
//       [
//         'Drinks',
//         '2',
//         '\$ 15',
//         '0.5 %',
//         '\$ 30',
//       ],
//       [
//         'Lemon',
//         '4',
//         '\$ 7',
//         '0.5 %',
//         '\$ 28',
//       ],
//     ];

//     pdf.addPage(
//       pw.MultiPage(
//         // header: (context) {
//         //   return pw.Text(
//         //     'Flutter Approach',
//         //     style: pw.TextStyle(
//         //       fontWeight: pw.FontWeight.bold,
//         //       fontSize: 15.0,
//         //     ),
//         //   );
//         // },
//         build: (context) {
//           return [
//             pw.Row(
//               children: [
//                 pw.Image(
//                   pw.MemoryImage(iconImage),
//                   height: 72,
//                   width: 72,
//                 ),
//                 pw.SizedBox(width: 1 * PdfPageFormat.mm),
//                 pw.Column(
//                   mainAxisSize: pw.MainAxisSize.min,
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text(
//                       'INVOICE',
//                       style: pw.TextStyle(
//                         fontSize: 17.0,
//                         fontWeight: pw.FontWeight.bold,
//                       ),
//                     ),
//                     pw.Text(
//                       'Flutter Approach',
//                       style: const pw.TextStyle(
//                         fontSize: 15.0,
//                         color: PdfColors.grey700,
//                       ),
//                     ),
//                   ],
//                 ),
//                 pw.Spacer(),
//                 pw.Column(
//                   mainAxisSize: pw.MainAxisSize.min,
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Text(
//                       'John Doe',
//                       style: pw.TextStyle(
//                         fontSize: 15.5,
//                         fontWeight: pw.FontWeight.bold,
//                       ),
//                     ),
//                     pw.Text(
//                       'john@gmail.com',
//                     ),
//                     pw.Text(
//                       DateTime.now().toString(),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             pw.SizedBox(height: 1 * PdfPageFormat.mm),
//             pw.Divider(),
//             pw.SizedBox(height: 1 * PdfPageFormat.mm),
//             pw.Text(
//               'Dear John,\nLorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium optio, eaque rerum! Provident similique accusantium nemo autem. Veritatis obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam nihil, eveniet aliquid culpa officia aut! Impedit sit sunt quaerat, odit, tenetur error',
//               textAlign: pw.TextAlign.justify,
//             ),
//             pw.SizedBox(height: 5 * PdfPageFormat.mm),

//             ///
//             /// PDF Table Create
//             ///
//             pw.Table.fromTextArray(
//               headers: tableHeaders,
//               data: tableData,
//               border: null,
//               headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//               headerDecoration:
//                   const pw.BoxDecoration(color: PdfColors.grey300),
//               cellHeight: 30.0,
//               cellAlignments: {
//                 0: pw.Alignment.centerLeft,
//                 1: pw.Alignment.centerRight,
//                 2: pw.Alignment.centerRight,
//                 3: pw.Alignment.centerRight,
//                 4: pw.Alignment.centerRight,
//               },
//             ),
//             pw.Divider(),
//             pw.Container(
//               alignment: pw.Alignment.centerRight,
//               child: pw.Row(
//                 children: [
//                   pw.Spacer(flex: 6),
//                   pw.Expanded(
//                     flex: 4,
//                     child: pw.Column(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                         pw.Row(
//                           children: [
//                             pw.Expanded(
//                               child: pw.Text(
//                                 'Net total',
//                                 style: pw.TextStyle(
//                                   fontWeight: pw.FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             pw.Text(
//                               '\$ 464',
//                               style: pw.TextStyle(
//                                 fontWeight: pw.FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         pw.Row(
//                           children: [
//                             pw.Expanded(
//                               child: pw.Text(
//                                 'Vat 19.5 %',
//                                 style: pw.TextStyle(
//                                   fontWeight: pw.FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             pw.Text(
//                               '\$ 90.48',
//                               style: pw.TextStyle(
//                                 fontWeight: pw.FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         pw.Divider(),
//                         pw.Row(
//                           children: [
//                             pw.Expanded(
//                               child: pw.Text(
//                                 'Total amount due',
//                                 style: pw.TextStyle(
//                                   fontSize: 14.0,
//                                   fontWeight: pw.FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             pw.Text(
//                               '\$ 554.48',
//                               style: pw.TextStyle(
//                                 fontWeight: pw.FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         pw.SizedBox(height: 2 * PdfPageFormat.mm),
//                         pw.Container(height: 1, color: PdfColors.grey400),
//                         pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
//                         pw.Container(height: 1, color: PdfColors.grey400),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ];
//         },
//         footer: (context) {
//           return pw.Column(
//             mainAxisSize: pw.MainAxisSize.min,
//             children: [
//               pw.Divider(),
//               pw.SizedBox(height: 2 * PdfPageFormat.mm),
//               pw.Text(
//                 'Flutter Approach',
//                 style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//               ),
//               pw.SizedBox(height: 1 * PdfPageFormat.mm),
//               pw.Row(
//                 mainAxisAlignment: pw.MainAxisAlignment.center,
//                 children: [
//                   pw.Text(
//                     'Address: ',
//                     style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                   ),
//                   pw.Text(
//                     'Merul Badda, Anandanagor, Dhaka 1212',
//                   ),
//                 ],
//               ),
//               pw.SizedBox(height: 1 * PdfPageFormat.mm),
//               pw.Row(
//                 mainAxisAlignment: pw.MainAxisAlignment.center,
//                 children: [
//                   pw.Text(
//                     'Email: ',
//                     style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//                   ),
//                   pw.Text(
//                     'flutterapproach@gmail.com',
//                   ),
//                 ],
//               ),
//             ],
//           );
//         },
//       ),
//     );

//     return FileHandleApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
//   }
// }

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:fyp/model/cart.dart';
import 'package:open_document/open_document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf_invoice_generator_flutter/model/product.dart';

class CustomRow {
  final String itemName;
  final String itemPrice;
  final String amount;
  final String total;
  final String vat;

  CustomRow(this.itemName, this.itemPrice, this.amount, this.total, this.vat);
}

class PdfInvoiceService {
  Future<Uint8List> createHelloWorld() {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello World"),
          );
        },
      ),
    );

    return pdf.save();
  }

  Future<Uint8List> createInvoice(List<CartItem> soldProducts) async {
    final pdf = pw.Document();

    final List<CustomRow> elements = [
      CustomRow("Item Name", "Item Price", "Amount", "Total", "Vat"),
      for (var product in soldProducts)
        CustomRow(
          product.title,
          product.price.toStringAsFixed(2),
          product.quantity!.toStringAsFixed(2),
          (product.price * product.quantity!).toStringAsFixed(2),
          (0.8 * product.price).toStringAsFixed(2),
        ),
      CustomRow(
        "Sub Total",
        "",
        "",
        "",
        "${getSubTotal(soldProducts)} EUR",
      ),
      CustomRow(
        "Vat Total",
        "",
        "",
        "",
        "${getVatTotal(soldProducts)} EUR",
      ),
      CustomRow(
        "Vat Total",
        "",
        "",
        "",
        "${(double.parse(getSubTotal(soldProducts)) + double.parse(getVatTotal(soldProducts))).toStringAsFixed(2)} EUR",
      )
    ];
    final image = (await rootBundle.load("assets/images/shops-fall.png"))
        .buffer
        .asUint8List();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Image(pw.MemoryImage(image),
                  width: 150, height: 150, fit: pw.BoxFit.cover),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    children: [
                      pw.Text("Customer Name"),
                      pw.Text("Customer Address"),
                      pw.Text("Customer City"),
                    ],
                  ),
                  pw.Column(
                    children: [
                      pw.Text("Max Weber"),
                      pw.Text("Weird Street Name 1"),
                      pw.Text("77662 Not my City"),
                      pw.Text("Vat-id: 123456"),
                      pw.Text("Invoice-Nr: 00001")
                    ],
                  )
                ],
              ),
              pw.SizedBox(height: 50),
              pw.Text(
                  "Dear Customer, thanks for buying at Flutter Explained, feel free to see the list of items below."),
              pw.SizedBox(height: 25),
              itemColumn(elements),
              pw.SizedBox(height: 25),
              pw.Text("Thanks for your trust, and till the next time."),
              pw.SizedBox(height: 25),
              pw.Text("Kind regards,"),
              pw.SizedBox(height: 25),
              pw.Text("Max Weber")
            ],
          );
        },
      ),
    );
    return pdf.save();
  }

  pw.Expanded itemColumn(List<CustomRow> elements) {
    return pw.Expanded(
      child: pw.Column(
        children: [
          for (var element in elements)
            pw.Row(
              children: [
                pw.Expanded(
                    child: pw.Text(element.itemName,
                        textAlign: pw.TextAlign.left)),
                pw.Expanded(
                    child: pw.Text(element.itemPrice,
                        textAlign: pw.TextAlign.right)),
                pw.Expanded(
                    child:
                        pw.Text(element.amount, textAlign: pw.TextAlign.right)),
                pw.Expanded(
                    child:
                        pw.Text(element.total, textAlign: pw.TextAlign.right)),
                pw.Expanded(
                    child: pw.Text(element.vat, textAlign: pw.TextAlign.right)),
              ],
            )
        ],
      ),
    );
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);
    print("File ==> " + file.path);
    await file.writeAsBytes(byteList);
    await OpenDocument.openDocument(filePath: filePath);
  }

  String getSubTotal(List<CartItem> products) {
    return products
        .fold(0.0,
            (double prev, element) => prev + (element.quantity! * element.price))
        .toStringAsFixed(2);
  }

  String getVatTotal(List<CartItem> products) {
    return products
        .fold(
          0.0,
          (double prev, next) =>
              prev + ((next.price / 100 ) * next.quantity!),
        )
        .toStringAsFixed(2);
  }
}
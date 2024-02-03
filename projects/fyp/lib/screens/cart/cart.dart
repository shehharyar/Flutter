// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fyp/provider/cart.dart';
// import 'package:fyp/screens/cart/cartList.dart';
// import 'package:open_file/open_file.dart';
// import 'package:pdf/pdf.dart' as pw;
// class CartScreen extends ConsumerWidget {
//   const CartScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final Carts = ref.watch(cartProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Your Carts"
//         ),
//       ),
//       body:Carts.isNotEmpty
//           ? Column(
//               children: [
//                 Expanded(
//                   child: CartList(items: Carts),
//                 ),
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     // _createPDF(cartItems);
//                   },
//                   icon: const Icon(Icons.check_circle_outline_outlined),
//                   label: const Text("Proceed"),
//                 ),
//               ],
//             )
//           : const Center(child: Text('No items in cart')),
//     );
//   }
// }


//   void _createPDF(List<CartItem> carts) async {
//     final pdf = pw.Document();
//     final file = File('${(await getTemporaryDirectory()).path}/carts.pdf');

//     pdf.addPage(
//       pw.MultiPage(
//         pageFormat: PdfPageFormat.a4,
//         build: (pw.Context context) {
//           return <pw.Widget>[
//             pw.Table.fromTextArray(
//               data: <List<String>>[
//                 <String>['Item', 'Price', 'Quantity'],
//                 ...carts.map((cart) => [cart.title, cart.price.toString(), cart.quantity.toString()]),
//               ],
//             ),
//           ];
//         },
//       ),
//     );

//     await file.writeAsBytes(await pdf.save());
//     OpenFile.open(file.path);
//   }

// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fyp/model/cart.dart';
import 'package:fyp/provider/cart.dart';
import 'package:fyp/screens/cart/cartList.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:uuid/uuid.dart';

FirebaseDatabase database = FirebaseDatabase.instance;
class CartScreen extends ConsumerWidget {
  const CartScreen({super.key, required this.shopId});
  final String shopId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carts = ref.watch(cartProvider);
    
   var uuid = const Uuid();

void _addToSales (List<CartItem> cartItems) async{
      
    _createPDF(cartItems);

    try{
      final salesId =uuid.v4();
Map<String, dynamic> saleData = {
      'timestamp': DateTime.now().toString(),
      'items': cartItems.map((cart) => {
        'title': cart.title,
        'price': cart.price,
        'quantity': cart.quantity,
        "porfit": (cart.price / 4) * cart.quantity,
        'id': salesId,
        'shopId': shopId
      }).toList(),
    };

      final sales= await database.ref().child('sales').child(salesId).set(saleData).then((value) {
      // If successful, clear the cart
      carts.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sale data added successfully')),
      );
    });
  } on FirebaseException

catch(e){
    ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? "Can't send data...")));
    }

    Navigator.of(context).pop();
}
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Carts"),
      ),
      body: carts.isNotEmpty
          ? Column(
              children: [
                Expanded(
                  child: CartList(items: carts),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _addToSales(carts);
                    // _createPDF(carts);
                    // carts.clear();
                  },
                  icon: const Icon(Icons.check_circle_outline_outlined),
                  label: const Text("Proceed"),
                ),
              ],
            )
          : const Center(child: Text('No items in cart')),
    );
  }

  void _createPDF(List<CartItem> carts) async {
    final pdf = pw.Document();
    final file = File('${(await getTemporaryDirectory()).path}/carts.pdf');

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          print(carts);
          return <pw.Widget>[
          
            // ignore: deprecated_member_use
            pw.Table.fromTextArray(
              data: <List<String>>[
                <String>['Item', 'Price', 'Quantity'],
                ...carts.map((cart) => [cart.title, cart.price.toString(), cart.quantity.toString()]),
              ],
            ),
          ];
        },
      ),
    );

    await file.writeAsBytes(await pdf.save());
    OpenFile.open(file.path);
   
  }
}
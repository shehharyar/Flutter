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
Future<void> _addToSales(List<CartItem> cartItems) async {
  _createPDF(cartItems);

  try {
    final salesId = uuid.v4();
    final currentDate = DateTime.now().toString().split(' ')[0]; // Get today's date
    Map<String, dynamic> saleData = {
      'timestamp': currentDate,
      'items': cartItems.map((cart) => {
        'title': cart.title,
        'price': cart.price,
        'quantity': cart.quantity,
        'profit': (cart.price / 4) * cart.quantity!, // Assuming profit calculation
        'id': salesId,
        'shopId': shopId
      }).toList(),
    };

    // Get existing sales data
    final existingSalesSnapshot = await database.ref().child('sales').once();
    Map<dynamic, dynamic>? existingSalesData = existingSalesSnapshot.snapshot.value as Map?;

    if (existingSalesData == null) {
      existingSalesData = {};
    }

    // Update or add items to the sales data
    saleData['items'].forEach((item) {
      bool itemExists = false;

      existingSalesData?.forEach((key, value) {
        if(value['timestamp'] == currentDate){
        List<dynamic> items = value['items'];
        for (var existingItem in items) {
          if (existingItem['title'] == item['title']) {
            // Update existing item
            existingItem['quantity'] += item['quantity'];
            existingItem['price'] += item['price'];
            existingItem['profit'] += item['profit'];
            itemExists = true;
            break;
          }
        }
     } });

      // If item doesn't exist, add it to the existing sales data
      if (!itemExists) {
        if (existingSalesData?[salesId] != null) {
          existingSalesData?[salesId]['items'].add(item);
        } else {
          existingSalesData?[salesId] = {
            'timestamp': currentDate,
            'items': [item]
          };
        }
      }
    });

    // Update the sales data in the database
    await database.ref().child('sales').set(existingSalesData);

    // Clear the cart if successful
    carts.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sale data added successfully')),
    );
  } on FirebaseException catch (e) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.message ?? "Can't send data...")),
    );
  }
}
// Future<void> _addToSales(List<CartItem> cartItems) async {
//   _createPDF(cartItems);

//   try {
//     final salesId = uuid.v4();
//     Map<String, dynamic> saleData = {
//       'timestamp': DateTime.now().toString(),
//       'items': cartItems.map((cart) => {
//         'title': cart.title,
//         'price': cart.price,
//         'quantity': cart.quantity,
//         'profit': (cart.price / 4) * cart.quantity, // Assuming profit calculation
//         'id': salesId,
//         'shopId': shopId
//       }).toList(),
//     };

//     // Get existing sales data
//     final existingSalesSnapshot = await database.ref().child('sales').once();
//    // Get existing sales data
// // final existingSalesSnapshot = await database.ref().child('sales').once();
// Map<dynamic, dynamic>? existingSalesData = existingSalesSnapshot.snapshot.value as Map?;

// if (existingSalesData == null) {
//   existingSalesData = {};
// }

// // Update or add items to the sales data
// saleData['items'].forEach((item) {
//   bool itemExists = false;
  
//   for (var value in existingSalesData!.values) { // Ensure existingSalesData is not null
//     List<dynamic> items = value['items'];
//     for (var existingItem in items) {
      
//       if (existingItem['id'] == item['id']) {
//         // Update existing item
//         existingItem['quantity'] += item['quantity'];
//         existingItem['price'] += item['price'];
//         existingItem['profit'] += item['profit'];
        
//         itemExists = true;
//         break;
//       }
//     }
//     if (itemExists) {
//       break;
//     }
//   }

//   // If item doesn't exist, add it to the existing sales data
//   if (!itemExists) {
//     existingSalesData[salesId] = saleData;
//   }
// });

//     // Update the sales data in the database
//     await database.ref().child('sales').set(existingSalesData);

//     // Clear the cart if successful
//     carts.clear();
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Sale data added successfully')),
//     );
//   } on FirebaseException catch (e) {
//     ScaffoldMessenger.of(context).clearSnackBars();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(e.message ?? "Can't send data...")),
//     );
//   }
// }
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
          // print(carts);
          return <pw.Widget>[
           pw.Center(
            child: pw.Text(
              'Shop Name',
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.SizedBox(height: 20),
          
            // ignore: deprecated_member_use
            pw.Table.fromTextArray(
              border: pw.TableBorder.all(),
            headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
            headerHeight: 25,
            cellHeight: 25,
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.center,
              2: pw.Alignment.center,
            },
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
   
   carts.clear();
  }
}
// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:fyp/provider/cart.dart';
// // import 'package:fyp/screens/cart/cartList.dart';
// // import 'package:open_file/open_file.dart';
// // import 'package:pdf/pdf.dart' as pw;
// // class CartScreen extends ConsumerWidget {
// //   const CartScreen({super.key});

// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final Carts = ref.watch(cartProvider);

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(
// //           "Your Carts"
// //         ),
// //       ),
// //       body:Carts.isNotEmpty
// //           ? Column(
// //               children: [
// //                 Expanded(
// //                   child: CartList(items: Carts),
// //                 ),
// //                 ElevatedButton.icon(
// //                   onPressed: () {
// //                     // _createPDF(cartItems);
// //                   },
// //                   icon: const Icon(Icons.check_circle_outline_outlined),
// //                   label: const Text("Proceed"),
// //                 ),
// //               ],
// //             )
// //           : const Center(child: Text('No items in cart')),
// //     );
// //   }
// // }


// //   void _createPDF(List<CartItem> carts) async {
// //     final pdf = pw.Document();
// //     final file = File('${(await getTemporaryDirectory()).path}/carts.pdf');

// //     pdf.addPage(
// //       pw.MultiPage(
// //         pageFormat: PdfPageFormat.a4,
// //         build: (pw.Context context) {
// //           return <pw.Widget>[
// //             pw.Table.fromTextArray(
// //               data: <List<String>>[
// //                 <String>['Item', 'Price', 'Quantity'],
// //                 ...carts.map((cart) => [cart.title, cart.price.toString(), cart.quantity.toString()]),
// //               ],
// //             ),
// //           ];
// //         },
// //       ),
// //     );

// //     await file.writeAsBytes(await pdf.save());
// //     OpenFile.open(file.path);
// //   }

// // ignore_for_file: use_build_context_synchronously


// // import 'package:flutter/services.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fyp/provider/cart.dart';
// import 'package:fyp/screens/cart/cartList.dart';
// import 'package:fyp/screens/payments/checkout.dart';

// FirebaseDatabase database = FirebaseDatabase.instance;

// class CartScreen extends ConsumerWidget {
//   const CartScreen({super.key, required this.shopId});
//   final String shopId;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final carts = ref.watch(cartProvider);
    
//   //  var uuid = const Uuid();
// // Future<void> _addToSales(List<CartItem> cartItems) async {
// //   _createPDF(cartItems);

// //   try {
// //     final salesId = uuid.v4();
// //     final currentDate = DateTime.now().toString().split(' ')[0]; // Get today's date
// //     Map<String, dynamic> saleData = {
// //       'timestamp': currentDate,
// //       'items': cartItems.map((cart) => {
// //         'title': cart.title,
// //         'price': cart.price,
// //         'quantity': cart.quantity,
// //         'profit': (cart.price / 4) * cart.quantity!, // Assuming profit calculation
// //         'id': salesId,
// //         'shopId': shopId
// //       }).toList(),
// //     };

// //     // Get existing sales data
// //     final existingSalesSnapshot = await database.ref().child('sales').once();
// //     Map<dynamic, dynamic>? existingSalesData = existingSalesSnapshot.snapshot.value as Map?;

// //     if (existingSalesData == null) {
// //       existingSalesData = {};
// //     }

// //     // Update or add items to the sales data
// //     saleData['items'].forEach((item) {
// //       bool itemExists = false;

// //       existingSalesData?.forEach((key, value) {
// //         if(value['timestamp'] == currentDate){
// //         List<dynamic> items = value['items'];
// //         for (var existingItem in items) {
// //           if (existingItem['title'] == item['title']) {
// //             // Update existing item
// //             existingItem['quantity'] += item['quantity'];
// //             existingItem['price'] += item['price'];
// //             existingItem['profit'] += item['profit'];
// //             itemExists = true;
// //             break;
// //           }
// //         }
// //      } });

// //       // If item doesn't exist, add it to the existing sales data
// //       if (!itemExists) {
// //         if (existingSalesData?[salesId] != null) {
// //           existingSalesData?[salesId]['items'].add(item);
// //         } else {
// //           existingSalesData?[salesId] = {
// //             'timestamp': currentDate,
// //             'items': [item]
// //           };
// //         }
// //       }
// //     });

// //     // Update the sales data in the database
// //     await database.ref().child('sales').set(existingSalesData);

// //     // Clear the cart if successful
// //     carts.clear();
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       const SnackBar(content: Text('Sale data added successfully')),
// //     );
// //   } on FirebaseException catch (e) {
// //     ScaffoldMessenger.of(context).clearSnackBars();
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(content: Text(e.message ?? "Can't send data...")),
// //     );
// //   }
// // }
// // Future<void> _addToSales(List<CartItem> cartItems) async {
// //   _createPDF(cartItems);

// //   try {
// //     final salesId = uuid.v4();
// //     Map<String, dynamic> saleData = {
// //       'timestamp': DateTime.now().toString(),
// //       'items': cartItems.map((cart) => {
// //         'title': cart.title,
// //         'price': cart.price,
// //         'quantity': cart.quantity,
// //         'profit': (cart.price / 4) * cart.quantity, // Assuming profit calculation
// //         'id': salesId,
// //         'shopId': shopId
// //       }).toList(),
// //     };

// //     // Get existing sales data
// //     final existingSalesSnapshot = await database.ref().child('sales').once();
// //    // Get existing sales data
// // // final existingSalesSnapshot = await database.ref().child('sales').once();
// // Map<dynamic, dynamic>? existingSalesData = existingSalesSnapshot.snapshot.value as Map?;

// // if (existingSalesData == null) {
// //   existingSalesData = {};
// // }

// // // Update or add items to the sales data
// // saleData['items'].forEach((item) {
// //   bool itemExists = false;
  
// //   for (var value in existingSalesData!.values) { // Ensure existingSalesData is not null
// //     List<dynamic> items = value['items'];
// //     for (var existingItem in items) {
      
// //       if (existingItem['id'] == item['id']) {
// //         // Update existing item
// //         existingItem['quantity'] += item['quantity'];
// //         existingItem['price'] += item['price'];
// //         existingItem['profit'] += item['profit'];
        
// //         itemExists = true;
// //         break;
// //       }
// //     }
// //     if (itemExists) {
// //       break;
// //     }
// //   }

// //   // If item doesn't exist, add it to the existing sales data
// //   if (!itemExists) {
// //     existingSalesData[salesId] = saleData;
// //   }
// // });

// //     // Update the sales data in the database
// //     await database.ref().child('sales').set(existingSalesData);

// //     // Clear the cart if successful
// //     carts.clear();
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       const SnackBar(content: Text('Sale data added successfully')),
// //     );
// //   } on FirebaseException catch (e) {
// //     ScaffoldMessenger.of(context).clearSnackBars();
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(content: Text(e.message ?? "Can't send data...")),
// //     );
// //   }
// // }
//     return Scaffold(
//       appBar: AppBar(
//         foregroundColor:Theme.of(context).colorScheme.onPrimary,
      
//       backgroundColor: Color.fromRGBO(27,9,61,1.000),
//         title: const Text("Your Carts", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
//       ),
//       body: Container(
//             decoration: const  BoxDecoration(
//           gradient: LinearGradient(  
//             begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//             colors: [Color.fromRGBO(27,9,61,1.000),Color.fromRGBO(82,36,91,1.000),])
//         ),
//         child: carts.isNotEmpty
//             ? Column(
//                 children: [
//                   Expanded(
//                     child: CartList(items: carts),
//                   ),
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                         builder: (ctx)=> CheckoutScreen(orders: carts,shopId:shopId)));
//                       // _addToSales(carts);
//                       // _createPDF(carts);
//                       // carts.clear();
//                     },
//                     icon: const Icon(Icons.check_circle_outline_outlined),
//                     label: const Text("Proceed"),
//                   ),
//                 ],
//               )
//             :  Center(child: 
//           Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 30, bottom: 20),
//                   child: Image.asset(
//                     'assets/images/cart.png',
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               const Text(
//                   "Your carts are empty!",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Sans Serif',
//                     color: Color.fromARGB(255, 239, 154, 154),
//                   ),
//                 ),
//               ],
//             ),)
//       ),
//     );
//   }

// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fyp/provider/cart.dart';
import 'package:fyp/screens/cart/cartList.dart';
import 'package:fyp/screens/payments/checkout.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({Key? key, required this.shopId});

  final String shopId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carts = ref.watch(cartProvider);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Color.fromRGBO(27, 9, 61, 1.000),
        title: const Text(
          "Your Carts",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromRGBO(27, 9, 61, 1.000), Color.fromRGBO(82, 36, 91, 1.000)],
          ),
        ),
        child: carts.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: CartList(items: carts),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx)=> CheckoutScreen(orders: carts,shopId:shopId)));
                      // _addToSales(carts);
                      // _createPDF(carts);
                      // carts.clear();
                    },
                    icon: const Icon(Icons.check_circle_outline_outlined),
                    label: const Text("Proceed"),
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(mediaQuery.size.width * 0.1),
                      child: Image.asset(
                        'assets/images/cart.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Text(
                      "Your carts are empty!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sans Serif',
                        color: Color.fromARGB(255, 239, 154, 154),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

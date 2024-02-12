// ignore_for_file: prefer_const_constructors

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fyp/model/cart.dart';
import 'package:fyp/provider/cart.dart';
class ProductItem extends ConsumerStatefulWidget {
  const ProductItem({
    Key? key,
    required this.id,
    required this.title,
    required this.cost,
    required this.stock,
    required this.others,
    required this.price,
    required this.imageUrl,
required this.onLongPress,
  }) : super(key: key);

  final String id;
  final String title;
  final String cost;
  final String stock;
  final String others;
  final String price;
  final String imageUrl;
    final VoidCallback onLongPress;


  @override
  ConsumerState<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends ConsumerState<ProductItem> {
  // late bool _selectedOnce = false;

   late int _stock;
  late int _quantity; // Add this line to track the quantity

  @override
  void initState() {
    super.initState();
        _stock = int.tryParse(widget.stock) ?? 0;
    _quantity = 0; // Initialize the quantity to 0
    _initializeRealtimeUpdates();
    // _stock = int.tryParse(widget.stock) ?? 0;
  }
  // void _cartHandler(CartItem item) {
  //   ref.read(cartProvider.notifier).toggleCartHandler(item);
  //       setState(() {
  //     _stock = (_stock - 1).clamp(0, _stock);
  //   });
  // }


  void _increment() {
    if (_quantity < _stock) {
      setState(() {
        _quantity++;
      });
      ref.read(cartProvider.notifier).addToCart(CartItem(
          id: widget.id,
          title: widget.title,
          image: widget.imageUrl,
          quantity: _quantity,
          price: double.parse(widget.price)));
      _updateStock(widget.id, _stock - 1);
    }
  }

  void _decrement() {
    if (_quantity > 0) {
      setState(() {
     _quantity=   _quantity--;
      });
      ref.read(cartProvider.notifier).decrementQuantity(widget.id);
      // _updateStock(widget.id, _stock + 1);
    }
  }

  void _initializeRealtimeUpdates() {
    DatabaseReference productRef =
        FirebaseDatabase.instance.ref('products').child(widget.id);
    productRef.child('stock').onValue.listen((event) {
      var data = event.snapshot.value;
      if (data != null) {
        setState(() {
          _stock = int.tryParse(data.toString()) ?? 0;
        });
      }
    });
  }

  void _updateStock(String productId, int newStock) {
    DatabaseReference productRef =
        FirebaseDatabase.instance.ref('products').child(productId);
    productRef.update({'stock': newStock});
  }
// void _increment() {
//    if (_quantity < _stock) {
//       setState(() {
//         _quantity++;
//       });
     
//     ref.read(cartProvider.notifier).addToCart(CartItem(id: widget.id, 
//     title: widget.title, image: widget.imageUrl, quantity:_quantity, price: double.parse(widget.price)));
//     _updateStock(widget.id,_stock - 1);
//       // _updateStock(widget.id, (_stock - 1) as int);
//     }
//   }

//   // void _decrement() {
//   //   ref.read(cartProvider.notifier).decrementQuantity(widget.id);
//   //   _updateStock(widget.id,_stock + 1);
//   // }

//   void _decrement() {
//     if (_quantity > 0) {
//       setState(() {
//         _quantity--;
//       });
//       ref.read(cartProvider.notifier).decrementQuantity(widget.id);
//       _updateStock(widget.id,_stock + 1);
//     }
//   }

//   void _initializeRealtimeUpdates() {
//     // Set up a database reference for the product
//     DatabaseReference productRef = FirebaseDatabase.instance.ref('products').child(widget.id);
//     // Listen for changes in the 'stock' value
//     productRef.child('stock').onValue.listen((event) {
//       var data = event.snapshot.value;
//       if (data != null) {
//         setState(() {
//           _stock = int.tryParse(data.toString()) ?? 0;
//         });
//       }
//     });
//   }

  // void _increment() {
  //   setState(() {
  //     _stock++;
  //   });
  // }

  void _addStock() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'New Stock'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _stock = int.tryParse(value) ?? 0;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  // Update the stock in the database
                  _updateStock(widget.id, _stock);
                  Navigator.of(context).pop();
                },
                child: Text('Update Stock'),
              ),
            ],
          ),
        );
      },
    );
  }
 
  // void _updateStock(String productId, int newStock) {
  //   // Update the stock in the database
  //   DatabaseReference productRef = FirebaseDatabase.instance.ref('products').child(productId);
  //   productRef.update({'stock': newStock});
  // }


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(185, 7, 0, 8),
      shadowColor: Color.fromARGB(255, 87, 51, 88),
      elevation: 8.0,
      child: GestureDetector(
        onLongPress:widget.onLongPress,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(22.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              width: double.infinity,
              height: (MediaQuery.of(context).size.height / 100) * 20,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              trailing: Text(
                "Stock: ${_stock.toString()}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                widget.price,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: MediaQuery.of(context).textScaleFactor * 12,
                ),
              ),
              title: Text(
                widget.title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 17),
              child: Divider(
                color: Colors.indigo,
              ),
            ),
            Consumer(builder: (context, ref, _) {
              final items = ref.watch(cartProvider);
              final itemIsSelected = items.any((item) => item.id == widget.id);
              final quantity = items
                  .where((item) => item.id == widget.id)
                  .fold(0, (sum, item) => sum + item.quantity!);
        
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 199, 149, 207),
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      onPressed:  _decrement ,
                      icon: Icon(
                        Icons.remove,
                        size: 25,
                        color: Color.fromARGB(255, 199, 149, 207),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      quantity.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 199, 149, 207),
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
      onPressed:(){
         _increment(); },
                    //   onPressed: () {
                    //     if(ref.watch(cartProvider).contains(widget.id)){
                    //         ref.read(cartProvider.notifier).incrementQuantity(widget.id);
        
                    //     }
                    //     else{
                    // _cartHandler(CartItem(id: widget.id, title: widget.title, image: widget.imageUrl, quantity: 1, price: double.parse(widget.price)));
                    // ref.read(cartProvider.notifier).incrementQuantity(widget.id);
                    //     }
        
                      disabledColor: Colors.grey,
                      icon: Icon(
                        Icons.add,
                        color: Color.fromARGB(255, 199, 149, 207) ,
                      ),
                    ),
                  ),
              
                ],
              );
            }),
 if(_stock == 0)
          OutlinedButton(onPressed: _addStock, child: Text("Add Stock"))              
          ],
        ),
      ),
    );
  }

    // else if(quantity > 0){
    
  
}


// class ProductItem extends ConsumerStatefulWidget {
//   const ProductItem({super.key, required this.id,required this.title, required this.cost, required this.price, required this.imageUrl});
//   final String id;
//   final String title;
//   final String cost;
//   final String price;
//   final String imageUrl;

//   @override
//   ConsumerState<ProductItem> createState() => _ProductItemState();
// }

// class _ProductItemState extends ConsumerState<ProductItem> {

//  late  bool _selectedOnce = false ;
//     void _cartHandler( CartItem item ){
//   ref.read(cartProvider.notifier).toggleCartHandler(item);
     
//       // if(_selectedOnce){
//       //   ref.read(CartProvider.notifier).removeFromCart(item.id);
//       //   setState(() {
//       //     _selectedOnce= false;
//       //   });
//       // }


//       // ref.read(CartProvider.notifier).addToCart(item);
//       // setState(() {
//       //   _selectedOnce= true;
//       // });


//     }

    
//   @override
//   Widget build(BuildContext context) {

//     CartItem item= CartItem(id: widget.id, title: widget.title, image: widget.imageUrl, quantity: 0,price: double.parse(widget.price));

//   final Items= ref.watch(cartProvider);
//   final itemIsSelected =  Items.any((item) => item.id == widget.id);

// print(itemIsSelected);
//     return Card(
//               color: Color.fromARGB(185, 7, 0, 8),
//               shadowColor: Color.fromARGB(255, 87, 51, 88),
//               elevation: 8.0,
//               child: Column(
//                 children: [
    
//                   Container(
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft:Radius.circular(22.0), 
//                         topRight:Radius.circular(12.0))),
//                     width: double.infinity,
//                     height: (MediaQuery.of(context).size.height/100) * 20 ,
//                     // height: 200,
//                     child: ClipRRect(
//                        borderRadius: const BorderRadius.only(
//                         topLeft:Radius.circular(12.0), 
//                         topRight:Radius.circular(12.0)),
    
//                       child: Image.network(widget.imageUrl,
//                       fit: BoxFit.cover,
                    
//                       ),
//                     )),
                    
//                   ListTile(
//                     trailing: Text("Stock: ${widget.cost}",
//                       style: TextStyle(
//                       color: Theme.of(context).colorScheme.onSecondary,
//                       fontWeight: FontWeight.bold
//                       ,                  
//                     ),),
//                     subtitle: Text(widget.price,
//                     style: TextStyle(
//                     color: Theme.of(context).colorScheme.onSecondary,
//                       fontSize: MediaQuery.of(context).textScaleFactor * 12
//                     ),
//                     ) ,
//                     title: Text(widget.title, 
//                     style: TextStyle(
//                       color: Theme.of(context).colorScheme.onSecondary,
//                       fontWeight: FontWeight.bold
//                       ,))),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.symmetric(vertical: 8),
//                       padding: const EdgeInsets.all(2),
//                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
//                       color:
//                       itemIsSelected ? Colors.deepOrange :
//                        Theme.of(context).colorScheme.onBackground,
//                        ),
//                       child:
//                       IconButton(onPressed: (){
//                           if(itemIsSelected){
//                             ref.read(cartProvider.notifier).removeFromCart(widget.id);
//                           }
//                           else{
//                             ref.read(cartProvider.notifier).addToCart(item);
//                           }
//                           // _cartHandler(CartItem(id: widget.id, title: widget.title, image: widget.imageUrl, quantity: 0, price: double.parse(widget.price)));
//                       }, icon: Icon(
//                         Icons.shopping_cart_rounded, 
//                         color:
//                         _selectedOnce ? Colors.deepOrangeAccent[50] :
//                          Theme.of(context).colorScheme.secondary))
//                        ,
//                     )
//                   ],
//                 )
//                 ],
    
//               ),
//             );
//   }
// }
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
  }) : super(key: key);

  final String id;
  final String title;
  final String cost;
  final String stock;
  final String others;
  final String price;
  final String imageUrl;

  @override
  ConsumerState<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends ConsumerState<ProductItem> {
  late bool _selectedOnce = false;

  void _cartHandler(CartItem item) {
    ref.read(cartProvider.notifier).toggleCartHandler(item);
  }

  void _decrement() {
    ref.read(cartProvider.notifier).decrementQuantity(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(185, 7, 0, 8),
      shadowColor: Color.fromARGB(255, 87, 51, 88),
      elevation: 8.0,
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
              "Stock: ${widget.stock}",
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
                .fold(0, (sum, item) => sum + item.quantity);

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
                    onPressed: _decrement,
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
                    onPressed: () {
                      ref.read(cartProvider.notifier).incrementQuantity(widget.id);
                    },
                    icon: Icon(
                      Icons.add,
                      color: Color.fromARGB(255, 199, 149, 207),
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
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
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fyp/model/cart.dart';
import 'package:fyp/provider/cart.dart';

class ProductActions extends ConsumerStatefulWidget {
  const ProductActions({super.key, required this.id, required this.item});
  final String id;
  final CartItem item;
  @override
  ConsumerState<ProductActions> createState() => _ProductActionsState();
}

class _ProductActionsState extends ConsumerState<ProductActions> {
  @override
  Widget build(BuildContext context) {
    
    void _cartHandler( CartItem item ){
  ref.read(cartProvider.notifier).toggleCartHandler(item);
  }
  
  void _decrement(){
       ref.read(cartProvider.notifier).decrementQuantity(widget.id);
}
final cart= ref.read(cartProvider.notifier);    
    // CartItem item= CartItem(id: widget.id, title: widget.title, image: widget.imageUrl, quantity: 0,price: double.parse(widget.price));

  final Items= ref.watch(cartProvider);
  final itemIsSelected =  Items.any((item) => item.id == widget.id);
final quantity= Items
                .where((item) => item.id == widget.id)
                .fold(0, (sum, item) => sum + item.quantity);

print(itemIsSelected);
print("Actions");
    return   Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        border: Border.all(color: const  Color.fromARGB(255, 199, 149, 207)),
                        borderRadius: BorderRadius.circular(50),),    
                  child:
                      IconButton(onPressed: _decrement, 
                      icon: Icon(
                        Icons.remove,
                        size: 25, 
                        color:  Color.fromARGB(255, 199, 149, 207),))
                       ,
                    ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text( 
                    quantity.toString(),                      
                    style: TextStyle(
                      color: Colors.white ),
                    ),
                  ),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color.fromARGB(255, 199, 149, 207)),
                        borderRadius: BorderRadius.circular(50),),    
                  child:
                      IconButton(onPressed: (){
                        print("Pressed");
                        // if(quantity < 0){
                        // ref.read(cartProvider.notifier).addToCart(widget.item);
                        // ref.read(cartProvider.notifier).incrementQuantity(widget.id);
                        // }
                        // else{

                        // ref.read(cartProvider.notifier).incrementQuantity(widget.id);
                        // }
ref.read(cartProvider.notifier).addToCart(widget.item);
                        ref.read(cartProvider.notifier).incrementQuantity(widget.id);

                      }, 
                      icon: Icon(
                        Icons.add, 
                        color:  Color.fromARGB(255, 199, 149, 207),))
                       ,
                    )
                  ],
                );
  }
}
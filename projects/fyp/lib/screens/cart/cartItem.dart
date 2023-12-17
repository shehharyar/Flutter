import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fyp/model/cart.dart';
import 'package:fyp/provider/cart.dart';

class CartItemWidget extends ConsumerWidget {
  const CartItemWidget({super.key, this.item});

  final CartItem? item;
  // final Function()? onIncrement;
  // final Function()? onDecrement;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return 
     Container(
      
      margin: EdgeInsets.symmetric(horizontal: 9, vertical: 13),
       child: Card(
        elevation: 7,
        color: Theme.of(context).colorScheme.primaryContainer,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(item!.image),
                      radius: 50,
                    ),
                  ),
            Container(
              child: Column(
                children: [
                  Text(item!.title,
                  style:  Theme.of(context).textTheme.displayMedium ,
                  ),
                  Text(item!.price.toString()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton.outlined(onPressed: (){
                    ref.read(cartProvider.notifier).updateQuantity(item!.id, item!.quantity.toInt() - 1 );  
                  }, icon: const Icon(Icons.remove)),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(item!.quantity.toString()),
                  ),
                  IconButton.outlined(onPressed: (){
                    ref.read(cartProvider.notifier).updateQuantity(item!.id, item!.quantity.toInt() +1);
                  }, icon: const Icon(Icons.add)),
                ],
              ),
            ),
            ],),

            
                ],
              )
            
          ),
        );
    
  }
}
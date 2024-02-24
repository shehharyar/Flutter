import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fyp/model/cart.dart';
import 'package:fyp/provider/cart.dart';

class CartItemWidget extends ConsumerStatefulWidget {
  const CartItemWidget({super.key,required this.item});

  final CartItem item;
  // final Function()? onIncrement;  
  ConsumerState<CartItemWidget> createState() => _CartItemState();
}

class _CartItemState extends ConsumerState<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    print("image==> " + widget.item.quantity!.toString());

    return Container(
  width: double.infinity,
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
                backgroundImage: NetworkImage(widget.item!.image),
                radius: 50,
              ),
            ),
           Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.title,
                    style: Theme.of(context).textTheme.displaySmall,
                    overflow: TextOverflow.ellipsis,
                          maxLines: 2, 
                  ),
                  Text(widget.item.price.toString()),
                ],
              ),
          
       Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        ref.read(cartProvider.notifier).decrementQuantity(widget.item.id);
                      setState(() {
                        widget.item.quantity = widget.item.quantity! - 1; 
                      });
                      },
                      icon: Icon(Icons.remove),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(widget.item.quantity!.toString()),
                    ),
                    IconButton(
                      onPressed: () {
                        ref.read(cartProvider.notifier).incrementQuantity(widget.item.id);
                      setState(() {
                        widget.item.quantity = widget.item.quantity! + 1; 
                      });
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
          
          ],
        ),
      ],
    ),
  ),
);
    
  }
}
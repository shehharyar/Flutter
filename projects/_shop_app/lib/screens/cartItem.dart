// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  const CartItem(this.id, this.productId, this.price, this.quantity, this.title,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Dismissible(
        key: ValueKey(id),
        background: Container(
          color: Theme.of(context).colorScheme.error,
          // ignore: sort_child_properties_last
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          cart.removeItem(productId);
        },
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(child: Text('\$$price')),
                ),
              ),
              title: Text(title),
              subtitle: Text('Total: \$${(price * quantity)}'),
              trailing: Text('$quantity'),
            ),
          ),
        ));
  }
}

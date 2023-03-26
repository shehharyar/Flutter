import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import './cartItem.dart' show CartItem;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Your cart"),
        ),
        body: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(fontSize: 20),
                      ),
                      const Spacer(),
                      Chip(
                        label: Text(
                          '\$${cart.totalAmount}',
                          style: TextStyle(color: Colors.white60),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Order Now",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      )
                    ]),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: cart.itemsCount,
                  itemBuilder: ((ctx, i) => CartItem(
                      cart.items.values.toList()[i].id,
                      cart.items.keys.toList()[i],
                      cart.items.values.toList()[i].price,
                      cart.items.values.toList()[i].quantity,
                      cart.items.values.toList()[i].title))),
            )
          ],
        ));
  }
}

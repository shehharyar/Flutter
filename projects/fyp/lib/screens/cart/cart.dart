import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fyp/provider/cart.dart';
import 'package:fyp/screens/cart/cartList.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Carts = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Carts"
        ),
      ),
      body: Container(
        height: double.infinity,

        child: Carts.isNotEmpty ? CartList(items: Carts) : 
        Center(
          child: Expanded(child: Text("You've not added Carts yet.", style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
          ),)),
        )
        ,
      ) ,
    );
  }
}
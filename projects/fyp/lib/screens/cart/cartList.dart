import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fyp/model/cart.dart';
import 'package:fyp/screens/cart/cartItem.dart';

class CartList extends ConsumerWidget {
 const  CartList({super.key, required this.items});

  final List<CartItem> items;

  @override
  Widget build(BuildContext context, WidgetRef ref ) {
  // final carts=  ref.watch(cartProvider);
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (ctx, i) => CartItemWidget(item: items[i],
    
      ),     
      );
  }
}
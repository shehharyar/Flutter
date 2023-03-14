import '../providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final product = productsData.items;
    return GridView.builder(
      itemCount: product.length,
      padding: const EdgeInsets.all(10.0),
      itemBuilder: ((ctx, i) => ChangeNotifierProvider(
            create: (c) => product[i],
            child: ProductItem(),
          )),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20),
    );
  }
}

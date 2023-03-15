import 'package:flutter/material.dart';
import '../providers/Product.dart';
import '../widgets/product_grid.dart';

class ProductOverviewScreen extends StatelessWidget {
  ProductOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products OverView")),
      body: const ProductsGrid(),
    );
  }
}

import 'package:provider/provider.dart';
import '../providers/Product.dart';
import '../screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // const ProductItem(this.id, this.title, this.imageUrl, {super.key});
  const ProductItem({super.key});
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(
                product.isFavourite ? Icons.favorite : Icons.favorite_border),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              product.toggleFavouriteStatus();
            },
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {},
          ),
        ),
        child: GestureDetector(
          onTap: (() {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          }),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

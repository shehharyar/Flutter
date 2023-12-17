import 'package:flutter/material.dart';
import 'package:fyp/widgets/UI/image-crousel.dart';
import 'package:fyp/widgets/products/products-short.dart';

class ShopHomeScreen extends StatelessWidget {
  const ShopHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
    
      // appBar:AppBar(backgroundColor: Theme.of(context).colorScheme.onSecondary,),
      body:  Container(
        width: double.infinity,
        // height: double.infinity,
      color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CarouselDemo(),
            const Text("Heading"),
            ProductListHome(),
          ],
        )
      )
    );
  }
}
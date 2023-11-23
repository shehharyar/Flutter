import 'package:flutter/material.dart';

class ShopHomeScreen extends StatelessWidget {
  const ShopHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
      color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
        child: const Center(
        child: Text("Home overview"),
      )),
    );
  }
}
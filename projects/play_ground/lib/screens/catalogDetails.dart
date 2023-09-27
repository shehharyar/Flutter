import 'package:flutter/material.dart';
import 'package:play_ground/models/Catalog.dart';

class CatalogDetailScreen extends StatelessWidget {
  const CatalogDetailScreen({super.key, this.catalog});
final Catalog? catalog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: const Text('Catalog Details')),
      body: const Center(
        child: Placeholder(
          color: Colors.white54,
          child: Text("Catalog Details"),
        ),
      ),
    );
  }
}

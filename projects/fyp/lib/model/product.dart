
// import 'package:firebase_database/firebase_database.dart';

class Product {
  final String? id;
  final String title;
  final String imageUrl;
  final double price;
  final int stock;

  Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.stock,
  });
}
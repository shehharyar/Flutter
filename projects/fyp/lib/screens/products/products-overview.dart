import 'package:flutter/material.dart';

class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({super.key});


  @override
  Widget build(BuildContext context) {
      final List<Map<String, dynamic>> _products =[
        {"pid" : "p1" ,"pname" : "Ice Cake", "Price" : 90, "imageUrl": "https://media.istockphoto.com/id/1257369278/photo/raspberry-mousse-cake-on-a-slate-black-plate.jpg"},
        {"pid" : "p2" ,"pname" : "Ice Cake", "Price" : 90, "imageUrl": "https://media.istockphoto.com/id/1194629015/photo/ice-cream-cake-with-chocolate-and-strawberries-on-plate-close-up-selective-focus.jpg?s=1024x1024&w=is&k=20&c=d5JSzRbgPjRu5Tb6h2yW7L1ZTncVHUgRZmP5oZW6iK8="},
        {"pid" : "p3" ,"pname" : "Ice Cake", "Price" : 90, "imageUrl": "https://media.istockphoto.com/id/1257369278/photo/raspberry-mousse-cake-on-a-slate-black-plate.jpg"},
        {"pid" : "p4" ,"pname" : "Ice Cake", "Price" : 90, "imageUrl": "https://media.istockphoto.com/id/1257369278/photo/raspberry-mousse-cake-on-a-slate-black-plate.jpg"},
      ];

    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
        child: ListView.builder(
          itemCount: _products.length,
          itemBuilder: (ctx, i) =>
          Card(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  // height: 200,
                  child: Image.network(_products[i]['imageUrl'],
                  width: double.infinity,
                  height: 200,
                  )),
                Text(_products[i]['pname'])

              ],
            ),
          )
        )
      ),
    );
  }
}
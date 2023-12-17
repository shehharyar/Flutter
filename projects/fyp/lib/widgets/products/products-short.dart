import 'package:flutter/material.dart';

class ProductListHome extends StatelessWidget {
  const ProductListHome({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> shops=[
      {
        "id": "s1",
        "name": "Grocery",
        "Incentives" : "12.00",
        "image": "https://images.pexels.com/photos/128402/pexels-photo-128402.jpeg"
      },
      {  
        "id": "s2",
        "name": "Grocery",
        "Incentives" : "12.00",
        "image": "https://images.pexels.com/photos/128402/pexels-photo-128402.jpeg"
      },
      {
          "id": "s3",
        "name": "Grocery",
        "Incentives" : "12.00",
        "image": "https://images.pexels.com/photos/128402/pexels-photo-128402.jpeg"
      },];
    
    return Container(
      width: double.infinity,
      height: double.infinity,
child: ListView.builder(itemBuilder: (ctx, i){
 return Card(
  child: Column(
    children: [
      
      Text(shops[i]['name']),
    ],
  ) 
 ,) ;
} ),
    );
  }
}
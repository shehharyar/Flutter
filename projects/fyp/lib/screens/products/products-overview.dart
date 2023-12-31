import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/products/productForm.dart';
import 'package:fyp/widgets/products/product-list.dart';

FirebaseDatabase database = FirebaseDatabase.instance;


class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({super.key, required this.shopId});
  final String shopId;
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
    
      body: Container(
        padding: const EdgeInsets.all(11),
        decoration:const BoxDecoration(
         gradient: LinearGradient(  
            begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
            colors: [Color.fromRGBO(27,9,61,1.000),Color.fromRGBO(82,36,91,1.000),])
        ),

        
        // color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
        child: ProductList(
          shopId: shopId, 
          // getProductsStream: getProductsStream, 
        )
    ),

      floatingActionButton: FloatingActionButton.small(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>  ManageProductScreen(sid:shopId) ));
      },
      child: const Icon(Icons.add,
      size: 24,
      color: Colors.purpleAccent,) 
      ,),
    
    );
  }
}



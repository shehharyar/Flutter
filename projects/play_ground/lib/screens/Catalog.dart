import 'package:flutter/material.dart';
import 'package:play_ground/screens/new_catalog.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Catalog Screen")),
      body: SingleChildScrollView(
        child: Column(children: [
           
        ]),
      ),
    floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context,MaterialPageRoute(builder: (ctx) => const NewCatalogScreen())
);    
}, child: Icon(Icons.add))
    );
  }
}
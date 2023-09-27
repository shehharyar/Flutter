// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:play_ground/models/Catalog.dart';
import 'package:play_ground/screens/catalogDetails.dart';
import 'package:play_ground/screens/new_catalog.dart';
import 'package:play_ground/widgets/catalog_item.dart';
class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key, this.title, required  this.catalogs});
  final String? title;
  final List<Catalog> catalogs;

void selectCatalog(BuildContext context, Catalog catalog) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => CatalogDetailScreen(
          catalog: catalog,
          // onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override 
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );

    if (catalogs.isNotEmpty) {
      content = ListView.builder(
        itemCount: catalogs.length,
        itemBuilder: (ctx, index) => CatalogItem(
          catalog: catalogs[index],
          onSelectCatalog: (Catalog Catalog) {
            selectCatalog(context, Catalog);
          },
        ),
      );
    }

    // if(title == null){
    //   return content;
    // }
 
 
 
    return Scaffold(
      appBar: AppBar(title: const Text("Catalog Screen")),
      body: content,
    floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context,MaterialPageRoute(builder: (ctx) => const NewCatalogScreen())
);    
}, child: const Icon(Icons.add))
    );
  }
}
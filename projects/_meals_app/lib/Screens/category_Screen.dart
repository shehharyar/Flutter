// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/category_item.dart';

class Categories_Screen extends StatelessWidget {
  const Categories_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DeliMeals")),
      body: GridView(
          // ignore: sort_child_properties_last
          padding: const EdgeInsets.all(25),
          // ignore: sort_child_properties_last
          children: DUMMY_CATEGORIES
              .map((category) =>
                  CategoryItem(category.id, category.title, category.color))
              .toList(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20)),
    );
  }
}

import 'package:flutter/material.dart';
import './dummy_data.dart';
import './category_item.dart';

class Categories_Screen extends StatelessWidget {
  const Categories_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
        // ignore: sort_child_properties_last
        children: DUMMY_CATEGORIES
            .map((category) => CategoryItem(category.title, category.color))
            .toList(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20));
  }
}

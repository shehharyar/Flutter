import 'package:flutter/material.dart';
import 'package:meals_app_updated/data/dummy_data.dart';
import 'package:meals_app_updated/screens/meals.dart';
import 'package:meals_app_updated/widgets/category_grid_item.dart';
import 'package:meals_app_updated/models/category.dart';
import 'package:meals_app_updated/models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToggleFavorite});
  final void Function(Meal meal) onToggleFavorite;

  
  void _selectCategory(BuildContext context, Category category){
final filteredCMeals= dummyMeals.where((meal) => meal.categories.contains(category.id)).toList();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealsScreen(
        title: category.title, 
      meals: filteredCMeals,
      onToggleFavorite: onToggleFavorite,)));
  }



  @override
  Widget build(BuildContext context) {
    return GridView(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20
        ),
        children:  [
          for(final category in availableCategories)
              CategoryGridItem(category: category, onSelectCategory: () {_selectCategory(context, category);},)
        ],
        
        );
     
  }
}
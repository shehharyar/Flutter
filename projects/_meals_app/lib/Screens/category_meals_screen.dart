// import '../widgets/meal_item.dart';
// import 'package:flutter/material.dart';
// import '../dummy_data.dart';
// import '../models//meal.dart';

// class CategoryMealsScreen extends StatefulWidget {
//   static const routeName = '/category-meals';
//   const CategoryMealsScreen({super.key});

//   @override
//   State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
// }

// class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
//   late String categoryTitle;
//   late List<Meal> displayedMeals;
//   var _loadedInitData = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Future<void> didChangeDependencies() async {
//     if (!_loadedInitData) {
//       final routeArgs =
//           ModalRoute.of(context)?.settings.arguments as Map<String, String>;
//       final categoryId = routeArgs['id'];
//       categoryTitle = routeArgs['title']!;
//       displayedMeals = DUMMY_MEALS.where(
//         (meal) {
//           return meal.categories.contains(categoryId);
//         },
//       ).toList();
//       _loadedInitData = true;
//     }
//     super.didChangeDependencies();
//   }

//   void _removeItem(String mealId) {
//     setState(() {
//       displayedMeals.removeWhere((meal) => meal.id == mealId);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(categoryTitle),
//       ),
//       body: ListView.builder(
//           itemBuilder: ((context, index) {
//             print(displayedMeals[index].complexity);
//             return MealItem(
//               id: displayedMeals[index].id,
//               title: displayedMeals[index].title,
//               imageUrl: displayedMeals[index].imageUrl,
//               duration: displayedMeals[index].duration,
//               affordability: displayedMeals[index].affordability,
//               complexity: displayedMeals[index].complexity,
//               removeItem: _removeItem,
//             );
//           }),
//           itemCount: displayedMeals.length),
//     );
//   }
// }

import 'package:_meals_app/dummy_data.dart';
import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  const CategoryMealsScreen(this.availableMeals, {super.key});

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> displayedMeals;
  var _loadedInitData = false;

  @override
  void initState() {
    // ...
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title']!;
      final categoryId = routeArgs['id'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            affordability: displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}

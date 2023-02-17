// ignore_for_file: prefer_const_constructors

import 'package:_meals_app/Screens/favourites_screen.dart';
import 'package:flutter/material.dart';
import './dummy_data.dart';
import './Screens/meal-detail-screen.dart';
import './Screens/category_meals_screen.dart';
import './Screens/tabs_screen.dart';
import './Screens/filters_screen.dart';
import './models/meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "gluten": false,
    "lactose": false,
    "vegetarian": false,
    "vegan": false,
  };

  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];
  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourites(String mealId) {
    final _existingIndex =
        favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (_existingIndex >= 0) {
      setState(() {
        favoriteMeals.removeAt(_existingIndex);
      });
    } else {
      setState(() {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool isFavouriteMeal(String id) {
    return favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          fontFamily: "Raleway",
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              subtitle1: const TextStyle(
                  fontSize: 20,
                  fontFamily: "RobotoCondensed",
                  fontWeight: FontWeight.bold)),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
              .copyWith(secondary: Colors.amber)),
      // home: const Categories_Screen(),
      initialRoute: "/",
      routes: {
        '/': (ctx) => TabsScreen(favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(isFavouriteMeal, _toggleFavourites),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_setFilters, _filters)
      },
    );
  }
}

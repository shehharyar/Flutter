import 'package:flutter/material.dart';
import 'package:meals_app_updated/models/meal.dart';
import 'package:meals_app_updated/screens/categories.dart';
import 'package:meals_app_updated/screens/filters.dart';
import 'package:meals_app_updated/screens/meals.dart';
import 'package:meals_app_updated/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget{
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
    
  }
}

class _TabsScreenState extends State<TabsScreen>{
  int _selectedPageIndex =0;
  final  List<Meal> _favoriteMeals =[];

  void _showInfoMessage(String message){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

void _toggleMealFavoriteStatus(Meal meal){
  final isExisting= _favoriteMeals.contains(meal);
  if(isExisting) {
    setState(() {
    _favoriteMeals.remove(meal);
    });
    _showInfoMessage("Meal is no longer a favorite.");
  } else{
    setState(() {
    _favoriteMeals.add(meal);  
    });
    _showInfoMessage("Marked as a favorite.");

  }
}

void _setScreen(String identifier){
  Navigator.of(context).pop();
  if(identifier == "filters"){
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
  }
  
}

void _selectPage(int index){
  setState(() {
     
    _selectedPageIndex= index;
  });
}

  @override
  Widget build(BuildContext context) {
    Widget _activePage = CategoriesScreen(onToggleFavorite: _toggleMealFavoriteStatus,);
    var activePageTitle = "Categories";
    if(_selectedPageIndex == 1){
      _activePage=  MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,);
      activePageTitle= 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle),),
      drawer: MainDrawer(onSelectScreen: _setScreen,),
      body: _activePage,
      bottomNavigationBar:  BottomNavigationBar(
        onTap: _selectPage,
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: "Categories"),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
      ]),
    );
    
  }
}   
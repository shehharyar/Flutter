import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:meals_app_updated/data/dummy_data.dart';
import 'package:meals_app_updated/models/meal.dart';
import 'package:meals_app_updated/providers/favorites_provider.dart';
import 'package:meals_app_updated/providers/meals_provider.dart';
import 'package:meals_app_updated/screens/categories.dart';
import 'package:meals_app_updated/screens/filters.dart';
import 'package:meals_app_updated/screens/meals.dart';
import 'package:meals_app_updated/widgets/main_drawer.dart';

const kInitialFilters= {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false
  };

class TabsScreen extends ConsumerStatefulWidget{
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
    
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen>{
  int _selectedPageIndex =0;
  final  List<Meal> _favoriteMeals =[];
  Map<Filter, bool> _selectedFilters= kInitialFilters;

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

void _setScreen(String identifier) async{
  Navigator.of(context).pop();
  if(identifier == "filters"){
  final result = await Navigator.of(context).push<Map<Filter, bool>>(
    MaterialPageRoute(
      builder: (ctx) =>  FiltersScreen(currentFilters: _selectedFilters,)
      )
      
      );
      setState(() {
        _selectedFilters= result ?? kInitialFilters ; 
      });
  }

  
}

void _selectPage(int index){
  setState(() {
     
    _selectedPageIndex= index;
  });
}

  @override
  Widget build(BuildContext context) {
    final meals= ref.watch(mealsProvider);
    final availableMeals= meals.where((meal) {
      if(_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree){
        return false;
      }
      if(_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }
      if(_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian){
        return false;
      }
      if(_selectedFilters[Filter.vegan]! && !meal.isVegan){
        return false;
      }
      return true;
    }).toList();
    
    
    Widget activePage = CategoriesScreen(
      // onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
      );
    var activePageTitle = "Categories";
    
    if(_selectedPageIndex == 1){
      final favoriteMeals= ref.watch(favoriteMealsProvider);
      activePage=  MealsScreen(
        meals: favoriteMeals,
        // onToggleFavorite: _toggleMealFavoriteStatus,);
      );
      activePageTitle= 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle),),
      drawer: MainDrawer(onSelectScreen: _setScreen,),
      body: activePage,
      bottomNavigationBar:  BottomNavigationBar(
        onTap: _selectPage,
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: "Categories"),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
      ]),
    );
    
  }
}   
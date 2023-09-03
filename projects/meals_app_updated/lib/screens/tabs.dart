import 'package:flutter/material.dart';
import 'package:meals_app_updated/screens/categories.dart';
import 'package:meals_app_updated/screens/meals.dart';

class TabsScreen extends StatefulWidget{
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
    
  }
}

class _TabsScreenState extends State<TabsScreen>{
  int _selectedPageIndex =0;

void _selectPage(int index){
  setState(() {
    _selectedPageIndex= index;
  });
}

  @override
  Widget build(BuildContext context) {
    Widget _activePage = const CategoriesScreen();
    var activePageTitle = "Categories";
    if(_selectedPageIndex == 1){
      _activePage= const MealsScreen(meals: []);
      activePageTitle= 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle),),
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
// ignore_for_file: no_leading_underscores_for_local_identifiers
import './main_drawer.dart';
import './favourites_screen.dart';
import 'package:flutter/material.dart';
import './category_Screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _pages = [
    {
      "page": const Categories_Screen(),
      "title": "Categpries",
    },
    {
      'page': const FavouriteScreen(),
      'title': 'Your Favourites',
    }
  ];

  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_pages);
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      // ignore: prefer_const_literals_to_create_immutables
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).secondaryHeaderColor,
          currentIndex: _selectedPageIndex,
          // type: BottomNavigationBarType.shifting,
          onTap: _selectPage,
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.category),
                label: "Categories"),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.star),
                label: "Favourites"),
          ]),
    );
  }
}
//  return DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           appBar: AppBar(
//               title: const Text("Meals"),
//               bottom: const TabBar(
//                 tabs: [
//                   Tab(
//                     icon: Icon(Icons.category),
//                     text: "Categories",
//                   ),
//                   Tab(
//                     icon: Icon(Icons.star),
//                     text: "Favourites",
//                   )
//                 ],
//               )),
//           body: const TabBarView(
//               children: [Categories_Screen(), FavouriteScreen()]),
//         ));

import 'package:flutter/material.dart';
import 'package:fyp/screens/business/business-reg.dart';
import 'package:fyp/screens/products/ShopHome.dart';
import 'package:fyp/screens/products/products-overview.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key, required this.id});
  final String id;

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
    int _selectedPageIndex =0;

 void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> shops =[
          "TechTresaure",
          "Ecom. Tech",
          "ockApi"
    ]; 
        Widget activePage = const ShopHomeScreen();
    // var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = const ProductsOverviewScreen();
    }
    if (_selectedPageIndex == 2) {
      activePage = const ProductsOverviewScreen();
    }

    
    
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
       foregroundColor: Theme.of(context).colorScheme.background,
        title: const Center(child:  Text("Your Shops")),
      ),
      body: activePage,
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Theme.of(context).colorScheme.background,
        onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const BusinessRegistrationScreen()));
           },
      child: const Icon(Icons.add_shopping_cart_sharp),
      ),
      
      bottomNavigationBar:  BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        unselectedItemColor: Theme.of(context).colorScheme.tertiary,
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        selectedItemColor: Colors.amberAccent,
        items: const  [
        BottomNavigationBarItem(icon: Icon(Icons.add), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.local_grocery_store), label: "Products" ),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: "Payments")

      ]),
    );
  }
}
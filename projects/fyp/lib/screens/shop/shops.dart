import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fyp/provider/cart.dart';
import 'package:fyp/screens/cart/cart.dart';
import 'package:fyp/screens/payments/payment.dart';
import 'package:fyp/screens/products/ShopHome.dart';
import 'package:fyp/screens/products/products-overview.dart';
import 'package:fyp/screens/shop/create-shop.dart';
import 'package:fyp/widgets/UI/badge.dart' as badge;
import 'package:fyp/widgets/UI/main-drawer.dart';
class ShopScreen extends ConsumerStatefulWidget {
  const ShopScreen({super.key, required this.id, required this.title});
  final String id;
  final String title;
  @override
  ConsumerState<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends ConsumerState<ShopScreen> {
    int _selectedPageIndex =0;

 void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'home') {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const CreateShopScreen(),
        ),
      );
    }
   else if (identifier == 'logout') {
       FirebaseAuth.instance.signOut();
    }
  }


  @override
  Widget build(BuildContext context) {
    
        Widget activePage = const ShopHomeScreen();
    // var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = const ProductsOverviewScreen();
    }
    if (_selectedPageIndex == 2) {
      activePage = const PaymentScreen();
    }

    final carts =ref.watch(cartProvider);
    
    return Scaffold(
      appBar: AppBar(
        // systemOverlayStyle: SystemUiOverlayStyle.light,
      actions: [

        badge.Badge(
          value: carts.length.toString(),
          child: IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => CartScreen()));
          }, icon: Icon(Icons.shopping_cart, color: Theme.of(context).colorScheme.onSecondary,)),
        )
      ],
       backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
       foregroundColor: Theme.of(context).colorScheme.background,
        title:  Center(child:  Text(widget.title)),
      ),

      body: activePage,
      // floatingActionButton: FloatingActionButton.small(
      //   backgroundColor: Theme.of(context).colorScheme.background,
      //   onPressed: (){
      //       Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const BusinessRegistrationScreen()));
      //      },
      // child: const Icon(Icons.add_shopping_cart_sharp),
      // ),
      drawer: MainDrawer(onSelectScreen: _setScreen,),
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
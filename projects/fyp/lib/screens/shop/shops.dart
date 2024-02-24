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
import 'package:google_nav_bar/google_nav_bar.dart';
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
    
        Widget activePage =  ShopHomeScreen(shopId: widget.id,);
    // var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = ProductsOverviewScreen(shopId: widget.id ,);
    }
    if (_selectedPageIndex == 2) {
      activePage = PaymentScreen(shopId: widget.id,);
    }

    final carts =ref.watch(cartProvider);
    
    return Scaffold(
      appBar: AppBar(
        // toolbarOpacity: 0.9,
    
      backgroundColor: Color.fromRGBO(27,9,61,1.000),
      actions: [

        badge.Badge(
          value: carts.length.toString(),
          child: IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => CartScreen(shopId: widget.id,)));
          }, icon: Icon(Icons.shopping_cart, color: Theme.of(context).colorScheme.onSecondary,)),
        )
      ],
      //  backgroundColor:
       foregroundColor: Theme.of(context).colorScheme.background,
        title:  Center(child:  Text(widget.title)),
      ),

      body: 
        activePage,
      bottomNavigationBar:
      
      Container(
 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        
        decoration: BoxDecoration(
          
        color:Color.fromRGBO(82,36,91,1.000),
        // rgba(131, 107, 137, 1)
          ),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(100, 131, 107, 137),
          borderRadius:BorderRadius.circular(26.0)
            ),  
            child: GNav(
              activeColor: Color.fromARGB(255, 255, 255, 255),
              tabBackgroundColor: Color.fromRGBO(104, 86, 109, 0.937),
              onTabChange:_selectPage ,
              selectedIndex: _selectedPageIndex,
              tabs:   const [
               GButton(
              
                  icon: Icons.home,
                  text: 'Home',
                ),
            GButton(
                  icon: Icons.category_rounded,
                  text: 'Products',
                ),
               GButton(
                  icon:Icons.payment,
                  text: 'Payment',
                ),
            
            ]),
          )
        ),
      
            
            
      
      drawer: MainDrawer(onSelectScreen: _setScreen,),
      // floatingActionButton: FloatingActionButton.small(
      //   backgroundColor: Theme.of(context).colorScheme.background,
      //   onPressed: (){
      //       Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const BusinessRegistrationScreen()));
      //      },
      // child: const Icon(Icons.add_shopping_cart_sharp),
      // ),
    //   bottomNavigationBar:  Container(
    //     color: Color.fromRGBO(82,36,91,1.000),
      
    //     // padding: const EdgeInsets.all(8.0),
    //     child:GNav(
          
    //       tabBackgroundColor: Color.fromRGBO(33, 29, 34, 0.938),
    //       tabs: const [
    //        GButton(

    //   icon: Icons.home,
    //   text: 'Home',
    // ),
    //        GButton(
    //   icon: Icons.category_rounded,
    //   text: 'Home',
    // ),
    //        GButton(
    //   icon:Icons.payment,
    //   text: 'Home',
    // ),

    //     ])
    //   ),
    );
  }
}

//  BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
//           unselectedItemColor: Theme.of(context).colorScheme.tertiary,
//           onTap: _selectPage,
//           currentIndex: _selectedPageIndex,
//           selectedItemColor: Colors.amberAccent,
//           items: const  [
//           BottomNavigationBarItem(icon: Icon(Icons.add), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.local_grocery_store), label: "Products" ),
//           BottomNavigationBarItem(icon: Icon(Icons.add), label: "Payments")
        
//         ]),
import 'package:flutter/material.dart';
import 'package:fyp/screens/business/business-reg.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final List<String> shops =[
          "TechTresaure",
          "Ecom. Tech",
          "ockApi"
    ]; 
    return Scaffold(
      appBar: AppBar(
       
        title: const Center(child:  Text("Your Shops")),
      ),
      body:Container(
        width: double.infinity,
                height: double.infinity,
                decoration:const BoxDecoration(
                  color: Color.fromARGB(255, 243, 240, 240)
                ),
                child: ListView.builder(
                  itemCount: shops.length,
                  itemBuilder: (context, index){
                 
                  return  Container(
                    
                    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    padding: const EdgeInsets.all(12), 
                    decoration: BoxDecoration(border: Border.all(
                      color: Colors.blueGrey

                    )), 
                 child: ListTile(
                    title: Text(shops[index]),
                    // style: ListTileStyle.list,
                  ),
                  );
                } ) ,
         
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.limeAccent,
        onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const BusinessRegistrationScreen()));
           },
      child: const Icon(Icons.add_shopping_cart_sharp),
      ),
      
      bottomNavigationBar:  BottomNavigationBar(
        selectedItemColor: Colors.amberAccent,
        items:  [
        BottomNavigationBarItem(icon: Icon(Icons.add), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: "Home" ),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: "Home")

      ]),
    );
  }
}
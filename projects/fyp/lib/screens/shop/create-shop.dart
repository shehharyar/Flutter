import 'package:flutter/material.dart';
import 'package:fyp/screens/shop/shops.dart';
class CreateShopScreen extends StatelessWidget {
  const CreateShopScreen({super.key});


  @override
  Widget build(BuildContext context) {
    
    final List<Map<String, dynamic>> shops=[
      {
        "id": "s1",
        "name": "Grocery",
        "Incentives" : "12.00",
        "image": "https://images.pexels.com/photos/128402/pexels-photo-128402.jpeg"
      },
      {  
        "id": "s2",
        "name": "Grocery",
        "Incentives" : "12.00",
        "image": "https://images.pexels.com/photos/128402/pexels-photo-128402.jpeg"
      },
      {
          "id": "s3",
        "name": "Grocery",
        "Incentives" : "12.00",
        "image": "https://images.pexels.com/photos/128402/pexels-photo-128402.jpeg"
      },
      {
          "id": "s4",
        "name": "Grocery",
        "Incentives" : "12.00",
        "image": "https://images.pexels.com/photos/128402/pexels-photo-128402.jpeg"
      },
      {
          "id": "s5",
        "name": "Grocery",
        "Incentives" : "12.00",
        "image": "https://images.pexels.com/photos/128402/pexels-photo-128402.jpeg"
      },
    ];
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        title:  Text("BUsiness App",
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary
        ),)),
        body: Container(
          color: Theme.of(context).colorScheme.primary,
          child: ListView.builder(
            itemCount: shops.length,
            itemBuilder: (ctx, i){
            return Card(
              
              color: Theme.of(context).colorScheme.primaryContainer,
              child: ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder:(ctx) =>
                    ShopScreen(  id: shops[i]['id'],)
                  ));
                } ,
                leading:
                CircleAvatar(
                  radius: 20.7,
                  child: Image.network(shops[i]['image']),
                ),
                 title: Text(shops[i]['name']),
                  trailing: Text(shops[i]["Incentives"]),
              ),
            );
          }),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          unselectedItemColor: Theme.of(context).navigationBarTheme.indicatorColor ,
        onTap: (value) {
          
        },
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: "Categories"),
        BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
      ]),
    ); 

    
  }
}
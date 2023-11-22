import 'package:flutter/material.dart';
class CreateShopScreen extends StatelessWidget {
  const CreateShopScreen({super.key});


  @override
  Widget build(BuildContext context) {
    
    final List<Map<String, dynamic>> shops=[
      {
        "name": "Grocery",
        "Incentives" : "12.00",
        "image": "https://images.pexels.com/photos/128402/pexels-photo-128402.jpeg"
      },
      {
        "name": "Grocery",
        "Incentives" : "12.00",
        "image": "https://images.pexels.com/photos/128402/pexels-photo-128402.jpeg"
      },
      {
        "name": "Grocery",
        "Incentives" : "12.00",
        "image": "https://images.pexels.com/photos/128402/pexels-photo-128402.jpeg"
      },
      {
        "name": "Grocery",
        "Incentives" : "12.00",
        "image": "https://images.pexels.com/photos/128402/pexels-photo-128402.jpeg"
      },
      {
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
        
                leading:
                CircleAvatar(
                  radius: 12.8,
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
import 'package:flutter/material.dart';
import 'package:fyp/screens/products/productForm.dart';

class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({super.key});


  @override
  Widget build(BuildContext context) {
      final List<Map<String, dynamic>> _products =[
        {"pid" : "p1" ,"pname" : "Deserts", 
        "Price" : 90, "Quantity": 50, 
        "imageUrl": "https://cdn.pixabay.com/photo/2017/02/17/23/23/strawberry-dessert-2076155_1280.jpg"},
        {"pid" : "p2" ,"pname" : "Ice Cake",
         "Price" : 90, 
         "Quantity": 10,
         "imageUrl": "https://media.istockphoto.com/id/1194629015/photo/ice-cream-cake-with-chocolate-and-strawberries-on-plate-close-up-selective-focus.jpg?s=1024x1024&w=is&k=20&c=d5JSzRbgPjRu5Tb6h2yW7L1ZTncVHUgRZmP5oZW6iK8="},
        {"pid" : "p3" ,"pname" : "Ice Cake", "Price" : 90, 
        "Quantity": 24,
        "imageUrl": "https://cdn.pixabay.com/photo/2017/06/17/19/16/ice-cream-2413248_640.jpg"},
        {"pid" : "p4" ,"pname" : "Ice Cake", "Price" : 90,
        "Quantity": 20,
         "imageUrl": "https://images.unsplash.com/photo-1570476922354-81227cdbb76c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8c3dlZXRzfGVufDB8fDB8fHww"},
      ];

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(11),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
        child: ListView.builder(
          itemCount: _products.length,
          itemBuilder: (ctx, i) =>
          Card(
            color: Theme.of(context).colorScheme.onSecondaryContainer.withOpacity(0.8),
            shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.7),
            elevation: 8.0,
            child: Column(
              children: [

                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft:Radius.circular(22.0), 
                      topRight:Radius.circular(12.0))),
                  width: double.infinity,
                  height: (MediaQuery.of(context).size.height/100) * 20 ,
                  // height: 200,
                  child: ClipRRect(
                     borderRadius: BorderRadius.only(
                      topLeft:Radius.circular(12.0), 
                      topRight:Radius.circular(12.0)),

                    child: Image.network(_products[i]['imageUrl'],
                    fit: BoxFit.cover,
                  
                    ),
                  )),
                  
                ListTile(
                  trailing: Text("Stock: ${_products[i]['Quantity']}",
                    style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontWeight: FontWeight.bold
                    ,                  
                  ),),
                  subtitle: Text("\$ ${_products[i]['Price']}",
                  style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: MediaQuery.of(context).textScaleFactor * 12
                  ),
                  ) ,
                  title: Text(_products[i]['pname'], 
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontWeight: FontWeight.bold
                    ,)))

              ],

            ),
          )
        )
      ),
      floatingActionButton: FloatingActionButton.large(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> const ManageProductScreen(id: null) ));
      },
      child: Icon(Icons.add,
      size: 24,
      color: Colors.purpleAccent,) 
      ,),
    );
  }
}
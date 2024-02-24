import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/business/business-reg.dart';
import 'package:fyp/widgets/shops/shopsList.dart';
class CreateShopScreen extends StatelessWidget {
 const CreateShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
              title: Text(
                "Swift Sales",
                style: TextStyle(
                  
                  color: Colors.orange,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.add_business,
                    color: Colors.deepOrange,
                  ),
                  
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => const BusinessRegistrationScreen()),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.exit_to_app_outlined,
                    color: Colors.deepOrange,
                  ),
                  onPressed: (){
                    FirebaseAuth.instance.signOut();
                  },
                  // onPressed: () {
                  //   Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (ctx) => const BusinessRegistrationScreen()),
                  //   );
                  // },
                )
              ],
            ),
            body: Container(
              width: 500,
          height:double.infinity,
           decoration: const  BoxDecoration(
          gradient: LinearGradient(  
            begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
            colors: [Color.fromRGBO(27,9,61,1.000),Color.fromRGBO(82,36,91,1.000),])
        ),
              child: ShopsList()),
            
          );
      
    
  }

}

// // class CreateShopScreen extends StatelessWidget {
// //   const CreateShopScreen({super.key});


// //   @override
// //   Widget build(BuildContext context) {
    
// //     final List<Map<String, dynamic>> shops=[
// //       {
// //         "id": "s1",
// //         "name": "Grocery",
// //         "Incentives" : "12.00",
// //         "image": "https://images.pexels.com/photos/128402/pexels-photo-128402.jpeg"
// //       },
// //       {  
// //         "id": "s2",
// //         "name": "Grocery",
// //         "Incentives" : "12.00",
// //         "image": "https://images.pexels.com/photos/128402/pexels-photo-128402.jpeg"
// //       },
// //       {
// //           "id": "s3",
// //         "name": "Grocery",
// //         "Incentives" : "12.00",
// //         "image": "https://images.pexels.com/photos/128402/pexels-photo-128402.jpeg"
// //       },
// //       {
// //           "id": "s4",
// //         "name": "Grocery",
// //         "Incentives" : "12.00",
// //         "image": "https://images.pexels.com/photos/128402/pexels-photo-128402.jpeg"
// //       },
// //       {
// //           "id": "s5",
// //         "name": "Grocery",
// //         "Incentives" : "12.00",
// //         "image": "https://images.pexels.com/photos/128402/pexels-photo-128402.jpeg"
// //       },
// //     ];
    
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
// //         title:  Text("BUsiness App",
// //         style: TextStyle(
// //           color: Theme.of(context).colorScheme.onPrimary
// //         ),),
// //         actions: [ 
// //           IconButton(icon: const Icon(Icons.add_business,
// //           color:  Colors.deepOrange,
// //           ),
// //           onPressed: (){
// //             Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const BusinessRegistrationScreen()));
// //           },
// //           )
// //         ],
// //         ),
// //         body: Container(
// //           color: Theme.of(context).colorScheme.primary,
// //           child: ListView.builder(
// //             itemCount: shops.length,
// //             itemBuilder: (ctx, i){
// //             return Card(
              
// //               color: Theme.of(context).colorScheme.primaryContainer,
// //               child: ListTile(
// //                 onTap: (){
// //                   Navigator.of(context).pushReplacement(MaterialPageRoute(
// //                     builder:(ctx) =>
// //                     ShopScreen( 
// //                           id: shops[i]['id'],
// //                           title: shops[i]['name'],                      
// //                         ),
// //                   ));
// //                   // Navigator.of(context).pushReplacement(MaterialPageRoute(
// //                   //   builder:(ctx) =>
// //                   //   ShopScreen(
                      
// //                   //       id: shops[i]['id'],)
// //                   // ));
// //                 } ,
// //                 leading:
// //                 CircleAvatar(
// //                   radius: 20.7,
// //                   child: Image.network(shops[i]['image']),
// //                 ),
// //                  title: Text(shops[i]['name']),
// //                   trailing: Text(shops[i]["Incentives"]),
// //               ),
// //             );
// //           }),
// //         ),
// //         bottomNavigationBar: BottomNavigationBar(
// //           backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
// //           unselectedItemColor: Theme.of(context).navigationBarTheme.indicatorColor ,
// //         onTap: (value) {
          
// //         },
// //         items: const [
// //         BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: "Categories"),
// //         BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
// //       ]),
// //     ); 

    
// //   }
// // }



// //  Future<List<Map<String, dynamic>>> fetchUserShops() async {
// //     final user = FirebaseAuth.instance.currentUser;
// //     if (user == null) {
// //       return [];
// //     }

// //     DatabaseReference shopsRef = FirebaseDatabase.instance.ref('shops');
// //     DataSnapshot shopsSnapshot = await shopsRef.orderByChild('owner').equalTo(user.uid).once();

// //     List<Map<String, dynamic>> shops = [];

// //     if (shopsSnapshot.value != null) {
// //       shopsSnapshot.value.forEach((key, value) {
// //         shops.add({
// //           'id': key,
// //           'name': value['name'],
// //           'Incentives': value['Incentives'],
// //           'image': value['image'],
// //         });
// //       });
// //     }

// //     return shops;
// //   }
// // }



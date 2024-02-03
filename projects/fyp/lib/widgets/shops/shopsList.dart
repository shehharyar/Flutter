import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fyp/widgets/shops/shopItem.dart';

class ShopsList extends StatefulWidget {
  const ShopsList({super.key});

  @override
  State<ShopsList> createState() => _ShopsListState();
}

class _ShopsListState extends State<ShopsList> {
 DatabaseReference data= FirebaseDatabase.instance.ref();
 
  @override
  Widget build(BuildContext context) {
        final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(stream: data.child('shops').orderByChild('owner').equalTo(user!.uid).onValue, builder: (context, shopSnapshots) {
        if( shopSnapshots.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(
              ),
            );
}
      if(! shopSnapshots.hasData ||  shopSnapshots.data!.snapshot.value == null){
        return const Center( 
          child: Text("No Products added yet!."),);
      }
      if(shopSnapshots.hasError){
        return const Center(
          child: Text("Something went wrong!"),
        );
      }


       
        final data = shopSnapshots.data!.snapshot.value;
        final List<dynamic> loadedProducts = data == null ? [] : List.from((data as Map<dynamic, dynamic>).values);

      // print(productData);

     
    //     final List<Map<Object, Object>> loadedProducts =
    //         productData != null ? List.from(productData as Iterable) : [];
    return ListView.builder(itemBuilder: (ctx, i) => 
    ShopItem(id: loadedProducts[i]['id'] as String? ?? '', 
    title:loadedProducts[i]['name']as String? ?? '',   
   ),
    
    itemCount: loadedProducts.length,
    );
       }
    
    );
  }
}

// class ShopsList extends StatelessWidget {
//   const ShopsList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       // Fetch the shops for the current authenticated user
//       future: fetchUserShops(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: 
                  
//              CircularProgressIndicator(),
//           );
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
//           return const Center(
//             child:
//           Text('No shops found.')
          
//           ); 
            
             
//         } else {
//           List<Map<String, dynamic>> shops = snapshot.data as List<Map<String, dynamic>>;

//           return  ListView.builder(
//                 itemCount: shops.length,
//                 itemBuilder: (ctx, i) {
//                               print('Sjop ID ====== ${shops[i]['shopId']}');

//                   return 
//   }
  
//   }
//   );
//   }
//   Future<List<Map<String, dynamic>>> fetchUserShops() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       return [];
//     }

//     DatabaseReference shopsRef = FirebaseDatabase.instance.ref('shops');
//     DatabaseEvent shopsSnapshot = await shopsRef.orderByChild('owner').equalTo(user.uid).onChildAdded;

//     List<Map<String, dynamic>> shops = [];

//     if (shopsSnapshot.snapshot.value != null) {
//       (shopsSnapshot.snapshot.value as Map).forEach((key, value) {
        
//         shops.add({
//           'id': key,
//           'name': value['name'],
//           'Incentives': value['Incentives'],
//           'image': value['image'],
//         });
//       });
//     }

//     return shops;
//   }

  
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/shop/shops.dart';
class ShopsList extends StatelessWidget {
  const ShopsList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Fetch the shops for the current authenticated user
      future: fetchUserShops(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: 
                  
             CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
          return const Center(
            child:
          Text('No shops found.')
          
          ); 
            
             
        } else {
          List<Map<String, dynamic>> shops = snapshot.data as List<Map<String, dynamic>>;

          return  ListView.builder(
                itemCount: shops.length,
                itemBuilder: (ctx, i) {
                  return Card(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => ShopScreen(
                              id: shops[i]['id'],
                              title: shops[i]['name'],
                            ),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        radius: 20.7,
                        child: const Icon(Icons.shopping_bag_outlined),
                      ),
                      title: Text(shops[i]['name']),
                      trailing: Text(shops[i]["products"] ?? "0"),
                    ),
                  );
                },
              );
  }
  
  }
  );
  }
  Future<List<Map<String, dynamic>>> fetchUserShops() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return [];
    }

    DatabaseReference shopsRef = FirebaseDatabase.instance.ref('shops');
    DatabaseEvent shopsSnapshot = await shopsRef.orderByChild('owner').equalTo(user.uid).once();

    List<Map<String, dynamic>> shops = [];

    if (shopsSnapshot.snapshot.value != null) {
      (shopsSnapshot.snapshot.value as Map).forEach((key, value) {
        
        shops.add({
          'id': key,
          'name': value['name'],
          'Incentives': value['Incentives'],
          'image': value['image'],
        });
      });
    }

    return shops;
  }

  
}

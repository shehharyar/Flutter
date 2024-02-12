import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/shop/shops.dart';
// class ShopItem extends StatelessWidget {
//   const ShopItem({super.key, required this.id, required this.title});
//   final String id;
//   final String title;
//   // final List<Object?> products;
//   // final String id:
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//                     color: Theme.of(context).colorScheme.primaryContainer,
//                     child: ListTile(
//                       onTap: () {
//                         Navigator.of(context).pushReplacement(
//                           MaterialPageRoute(
//                             builder: (ctx) => ShopScreen(
//                               id: id,
//                               title: title,
//                             ),
//                           ),
//                         );
//                       },
//                       leading: CircleAvatar(
//                         radius: 20.7,
//                         child: const Icon(Icons.shopping_bag_outlined),
//                       ),
//                       title: Text(title),
//                       trailing: const Text("0"),
//                     ),
//                   );
              
//   } 
// }
  final DatabaseReference _data = FirebaseDatabase.instance.ref();

class ShopItem extends StatelessWidget {
  const ShopItem({Key? key, required this.id, required this.title}) : super(key: key);

  final String id;
  final String title;

  @override
  Widget build(BuildContext context) {
  Future<void> _deleteShop(String shopId) async {
    try {
      await FirebaseDatabase.instance.ref('shops').child(shopId).remove();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Shop deleted successfully')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete shop: $error')),
      );
    }
  }
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => ShopScreen(
                id: id,
                title: title,
              ),
            ),
          );
        },
        leading: CircleAvatar(
          radius: 20.7,
          child: const Icon(Icons.shopping_bag_outlined),
        ),
        title: Text(title),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            // Call a method to delete the shop
            _deleteShop(id);
          },
        ),
      ),
    );
  }

 
}
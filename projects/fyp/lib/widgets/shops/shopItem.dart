import 'package:flutter/material.dart';
import 'package:fyp/screens/shop/shops.dart';
class ShopItem extends StatelessWidget {
  const ShopItem({super.key, required this.id, required this.title});
  final String id;
  final String title;
  // final List<Object?> products;
  // final String id:
  @override
  Widget build(BuildContext context) {
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
                      trailing: const Text("0"),
                    ),
                  );
              
  } 
}
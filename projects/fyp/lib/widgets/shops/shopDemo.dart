// import 'package:flutter/material.dart';

// class shopListDemo extends StatelessWidget {
//   const shopListDemo({super.key});


// Future<void> _setShops() async{

// DatabaseReference database= FirebaseDatabase.instance.ref();     
// final user = FirebaseAuth.instance.currentUser;
// final shopsRef =database.child('shops');
// final shopsSnapshot = await shopsRef.orderByChild('owner').equalTo(user?.uid).get();

// if (shopsSnapshot.exists) {
//   final List<dynamic> shops = [];
//   shopsSnapshot.forEach((shopSnapshot) {
//     shops.add(shopSnapshot.value);
//   });
//   // Now, 'shops' contains the shops owned by the current user
// }
// }

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
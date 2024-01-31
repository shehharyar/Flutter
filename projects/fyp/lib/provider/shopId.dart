// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class ShopIdState {
//   final String currentShopId;

//   ShopIdState(this.currentShopId);
// }


// class ShopIdNotifier extends Notifier<ShopIdState> {
//   ShopIdNotifier() : super(ShopIdState(''));

//   void switchShop(String newShopId) {
//     state = ShopIdState(newShopId);
//   }
  
// }

// final shopIdProvider = StateNotifierProvider<ShopIdNotifier, ShopIdState>((ref) {
//   return ShopIdNotifier();
// });
// // class ShopIdNotifier extends StateNotifier<String> {
// //   ShopIdNotifier(String state) : super(state);

// //   // This method should be asynchronous if you're fetching the shopId from the database
  
// //   void switchShop(String newShopId) {
// //     if (newShopId != state) {
// //        state = ShopIdState(newShopId) as String;
// //     }
// //   }
// // }

// // final shopIdProvider = NotifierProvider<ShopIdNotifier, ShopIdState>((ref) => ShopIdNotifier(ShopIdState('')) as ShopIdNotifier Function() as ShopIdNotifier Function() as ShopIdNotifier Function());

// // // final cartProvider = StateNotifierProvider<cartNotifier, List<CartItem>>((ref) => cartNotifier() );
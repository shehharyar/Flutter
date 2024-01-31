import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fyp/model/cart.dart';

class cartNotifier extends StateNotifier<List<CartItem>>{
  cartNotifier() : super(  [] );
// bool isSelected = false;

bool toggleCartHandler (CartItem item){
   final itemIsSelected = state.contains(item);

    if (itemIsSelected) {
      state = state.where((m) => m.id != item.id).toList();
      return false;
    } else {
      state = [...state, item];
      return true;
    }
}


//  void addToCart(CartItem item){
//     state= [...state, item];
//     // isSelected= 
//  }
//  void removeFromCart(String itemId) {
//     state = state.where((item) => item.id != itemId).toList();
//   }

//   void updateQuantity(String itemId, int newQuantity) {
//     state = state.map((item) {
//       if (item.id == itemId) {
//         return item.copyWith(quantity: newQuantity);
//       } else {
//         return item;
//       }
//     }).toList();
//   }
 void addToCart(CartItem item) {
    state = [...state, item];
  }

  void removeFromCart(String itemId) {
    state = state.where((item) => item.id != itemId).toList();
  }

  void updateQuantity(String itemId, int newQuantity) {
    state = state.map((item) {
      if (item.id == itemId) {
        return item.copyWith(quantity: newQuantity);
      } else {
        return item;
      }
    }).toList();
  }

  void decrementQuantity(String itemId) {
    final index = state.indexWhere((item) => item.id == itemId);

    if (index != -1 && state[index].quantity > 1) {
      state[index] = state[index].copyWith(quantity: state[index].quantity - 1);
    } else {
      state = [...state.sublist(0, index), ...state.sublist(index + 1)];
    }
  }

  void incrementQuantity(String productId) {
    final index = state.indexWhere((item) => item.id == productId);

    if (index != -1) {
      state = [
        ...state.sublist(0, index),
        state[index].copyWith(quantity: state[index].quantity + 1),
        ...state.sublist(index + 1),
      ];
    } else {
      addToCart(CartItem(id: productId, title: "", image: "", quantity: 1, price: 0));
    }
  }
}



final cartProvider = StateNotifierProvider<cartNotifier, List<CartItem>>((ref) => cartNotifier() );
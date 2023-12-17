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


 void addToCart(CartItem item){
    state= [...state, item];
    // isSelected= 
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

}


final cartProvider = StateNotifierProvider<cartNotifier, List<CartItem>>((ref) => cartNotifier() );
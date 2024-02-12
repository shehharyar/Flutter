import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fyp/model/cart.dart';
// import 'package:fyp/mode.dart';

class cartNotifier extends StateNotifier<List<CartItem>>{
  cartNotifier() : super(  [] );
// bool isSelected = false;
void addToCart(CartItem item) {
  final index = state.indexWhere((element) => element.id == item.id);
  if (index != -1) {
    // If the item already exists, update its quantity
    state[index] = state[index].copyWith(quantity: state[index].quantity! + 1);
  } else {
    // Otherwise, add the item to the cart
    state = [...state, item.copyWith(quantity: 1)];
  }
}
  void removeFromCart(String itemId) {
    state = state.where((item) => item.id != itemId).toList();
  }

  // void updateQuantity(String itemId, int newQuantity) {
  //   final index = state.indexWhere((item) => item.id == itemId);
  //   if (index != -1) {
  //     state[index] = state[index].copyWith(quantity: newQuantity);
  //   }
  // }
void updateQuantity(String itemId, int newQuantity) {
  final index = state.indexWhere((item) => item.id== itemId);
  if (index != -1) {
    if (newQuantity > 0) {
      state[index].quantity = newQuantity;
    } else {
      state.removeAt(index);
    }
    // notifyListeners();
  }
}
// void decrementQuantity(String itemId) {
//   final index = state.indexWhere((item) => item.id == itemId);
//   if (index != -1) {
//     if (state[index].quantity! > 1) {
//       print("Item is less than 1");
//       state[index] = state[index].copyWith(quantity: state[index].quantity!.toInt() - 1);
//     } else {
//       // If quantity is 1, remove the item from the cart
//       state = [...state.sublist(0, index), ...state.sublist(index + 1)];
//     }
//   }
// }
  void decrementQuantity(String itemId) {
    final index = state.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      if (state[index].quantity! > 1) {
        state[index] = state[index].copyWith(quantity: state[index].quantity! - 1);
        // state[index].quantity=
      } else {
        // If quantity is 1, remove the item from the cart
        state = [...state.sublist(0, index), ...state.sublist(index + 1)];
      }
    }
  }

  void incrementQuantity(String itemId) {
    final index = state.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      state[index] = state[index].copyWith(quantity: state[index].quantity! + 1);
    }
  }
// bool toggleCartHandler (CartItem item){
//    final itemIsSelected = state.contains(item);

//     if (itemIsSelected) {
//       state = state.where((m) => m.id != item.id).toList();
//       return false;
//     } else {
//       state = [...state, item];
//       return true;
//     }
// }


// //  void addToCart(CartItem item){
// //     state= [...state, item];
// //     // isSelected= 
// //  }
// //  void removeFromCart(String itemId) {
// //     state = state.where((item) => item.id != itemId).toList();
// //   }

// //   void updateQuantity(String itemId, int newQuantity) {
// //     state = state.map((item) {
// //       if (item.id == itemId) {
// //         return item.copyWith(quantity: newQuantity);
// //       } else {
// //         return item;
// //       }
// //     }).toList();
// //   }
//  void addToCart(CartItem item) {
//     state = [...state, item];
//   }

//   void removeFromCart(String itemId) {
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

//   void decrementQuantity(String itemId) {
//     final index = state.indexWhere((item) => item.id == itemId);

//     if (index != -1 && state[index].quantity > 1) {
//       state[index] = state[index].copyWith(quantity: state[index].quantity - 1);
//     } else {
//       state = [...state.sublist(0, index), ...state.sublist(index + 1)];
//     }
//   }

//   void incrementQuantity(String productId) {
//     final index = state.indexWhere((item) => item.id == productId);

//     if (index != -1) {
//       state = [
//         ...state.sublist(0, index),
//         state[index].copyWith(quantity: state[index].quantity + 1),
//         ...state.sublist(index + 1),
//       ];
//     } else {
//       addToCart(CartItem(id: productId, title: "", image: "", quantity: 1, price: 0));
//     }
//   }
}



final cartProvider = StateNotifierProvider<cartNotifier, List<CartItem>>((ref) => cartNotifier() );
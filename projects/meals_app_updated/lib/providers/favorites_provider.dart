import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app_updated/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>>{
  FavoriteMealsNotifier() : super([]);

  bool toggleMealVoriteStatus (Meal meal){
    final mealIsFavorite = state.contains(meal);

    if(mealIsFavorite){
      state= state.where((m) => m.id != meal.id).toList();
      return false;
    }
    else{
      state= [...state, meal];
      return true;
    }
  }
}

final  favoriteMealsProvider = StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref){
  return FavoriteMealsNotifier();
});
import '../models/meal.dart';
import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';

class FavouriteScreen extends StatelessWidget {
  final List<Meal> favouritesMeal;

  const FavouriteScreen(this.favouritesMeal, {super.key});

  @override
  Widget build(BuildContext context) {
    if (favouritesMeal.isEmpty) {
      return Center(
        child: Text("You have no favourites yet - start adding some,  "),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favouritesMeal[index].id,
            title: favouritesMeal[index].title,
            imageUrl: favouritesMeal[index].imageUrl,
            duration: favouritesMeal[index].duration,
            affordability: favouritesMeal[index].affordability,
            complexity: favouritesMeal[index].complexity,
          );
        },
        itemCount: favouritesMeal.length,
      );
    }
  }
}

import "package:flutter/material.dart";
import "../dummy_data.dart";

class MealDetailScreen extends StatelessWidget {
  static const routeName = "/meal-detail ";
  final Function toggleFavourites;
  final Function IsFavourite;
  const MealDetailScreen(this.IsFavourite, this.toggleFavourites, {super.key});
  Widget buildSelectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        height: 150,
        width: 300,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSelectionTitle(context, "Ingredients"),
            buildContainer(
              ListView.builder(
                itemBuilder: ((ctx, index) => Card(
                      color: Theme.of(context).colorScheme.secondary,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Text(selectedMeal.ingredients[index]),
                      ),
                    )),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSelectionTitle(context, "Steps"),
            buildContainer(ListView.builder(
              itemBuilder: ((context, index) => Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: Text('# ${index + 1}'),
                        ),
                        title: Text(selectedMeal.steps[index]),
                      ),
                      const Divider()
                    ],
                  )),
              itemCount: selectedMeal.steps.length,
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(IsFavourite(mealId) ? Icons.star : Icons.star_border),
          onPressed: () => toggleFavourites(mealId)
          // () {
          //   // Navigator.of(context).pop(mealId);

          // },
          ),
    );
  }
}

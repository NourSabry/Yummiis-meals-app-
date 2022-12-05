// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
 
class MealDetailsScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  final Function toggleFavotire;
  final Function isFavorite;

  const MealDetailsScreen(this.toggleFavotire, this.isFavorite);
  Widget buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildListView(BuildContext context, Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: SizedBox(
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments;
    final selectMeal = dummyMeals.firstWhere((meals) => meals.id == mealId);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(selectMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 10),
              child: Image.network(
                selectMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle("ingredients"),
            buildListView(
              context,
              ListView.builder(
                itemCount: selectMeal.ingredients.length,
                itemBuilder: ((context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.1),
                      border: Border.all(
                        color: const Color.fromARGB(255, 240, 228, 121),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        selectMeal.ingredients[index],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            buildSectionTitle("steps"),
            buildListView(
              context,
              ListView.builder(
                itemBuilder: ((context, index) => Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 240, 228, 121),
                            ),
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor: Colors.black,
                              child: Text(
                                " #${index + 1}",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            title: Text(
                              selectMeal.steps[index],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(),
                      ],
                    )),
                itemCount: selectMeal.steps.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20),
              child: GestureDetector(
                onTap: () => [
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      content: const Text(
                        "this meal is has been deleted",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Navigator.of(context).pop(mealId)
                ],
                child: const Text(
                  "Delete meal",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor:
              Theme.of(context).colorScheme.secondary.withOpacity(0.3),
          onPressed:
              // Navigator.of(context).pop(mealId);
              () => [
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        content: Text(
                          isFavorite(mealId)
                              ? "this meal is successfuly removed from your favorites!"
                              : "this meal is successfuly added to favorites!",
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    ...toggleFavotire(mealId)
                  ],
          child: Icon(isFavorite(mealId) ? Icons.star : Icons.star_border)
          //  const Icon(Icons.delete),
          ),
    );
  }
}

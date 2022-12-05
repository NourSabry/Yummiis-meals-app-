// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meals_item.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favouritesMeal;

  const FavouritesScreen(this.favouritesMeal);

  @override
  Widget build(BuildContext context) {
    if (favouritesMeal.isEmpty) {
      return const Center(
        child: Text(
          "You have no favourites yet, start adding some! :'( ",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      );
    }
    return ListView.builder(
      itemBuilder: ((context, index) => MealsItem(
            title: favouritesMeal[index].title,
            imageUrl: favouritesMeal[index].imageUrl,
            duration: favouritesMeal[index].duration,
            complexity: favouritesMeal[index].complexity,
            affordability: favouritesMeal[index].affordability,
            id: favouritesMeal[index].id,
            // removeItem: favouritesMeal,
          )),
      itemCount: favouritesMeal.length,
    );
  }
}

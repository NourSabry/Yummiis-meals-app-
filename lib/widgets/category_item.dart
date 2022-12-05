// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:meals_app/screens/category_meals.dart';

class CategoriesItem extends StatelessWidget {
  final String? image;
  final String? title;
  final String? id;
  const CategoriesItem(this.image, this.title, this.id);

  void selectCategory(BuildContext context) {
    Navigator.of(context).pushNamed(CategoriesMealScreen.routeName, arguments: {
      'id': id,
      'title': title,
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 2,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image!),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Center(
          child: Card(
            color: const Color.fromARGB(19, 0, 0, 0),
            child: Text(
              title!,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

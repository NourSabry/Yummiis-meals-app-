// ignore_for_file: use_key_in_widget_constructors, unused_local_variable

import 'package:flutter/material.dart';
 import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meals_item.dart';

class CategoriesMealScreen extends StatefulWidget {
  static const routeName = 'category-meals';
  final List<Meal> availableMeals;
  const CategoriesMealScreen(this.availableMeals);

  @override
  State<CategoriesMealScreen> createState() => _CategoriesMealScreenState();
}

class _CategoriesMealScreenState extends State<CategoriesMealScreen> {
  String? catTitle;
  List<Meal>? displayMeals;
  var _loadedIntialData = false;
  @override
  void initState() {
//...
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedIntialData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String?>;
      catTitle = routeArgs['title']!;
      final catId = routeArgs['id'];
      displayMeals = widget.availableMeals.where((meals) {
        return meals.categories.contains(catId);
      }).toList();
    }

    _loadedIntialData = true;
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayMeals!.removeWhere((meal) => mealId == meal.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(catTitle!),
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) => MealsItem(
              title: displayMeals![index].title,
              imageUrl: displayMeals![index].imageUrl,
              duration: displayMeals![index].duration,
              complexity: displayMeals![index].complexity,
              affordability: displayMeals![index].affordability,
              id: displayMeals![index].id,
              removeItem: _removeMeal,
            )),
        itemCount: displayMeals!.length,
      ),
    );
  }
}

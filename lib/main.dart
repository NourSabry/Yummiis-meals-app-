// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/Filter_screen.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/category_meals.dart';
import 'package:meals_app/screens/meals_details_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filter = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = dummyMeals;
  final List<Meal> _favouritedMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filter = filterData;
      _availableMeals = dummyMeals.where((meal) {
        if (_filter['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filter['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filter['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filter['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void toggleFavourite(String mealId) {
    final exisitingIndex =
        _favouritedMeals.indexWhere((meal) => meal.id == mealId);
    if (exisitingIndex >= 0) {
      setState(() {
        _favouritedMeals.removeAt(exisitingIndex);
      });
    } else {
      setState(() {
        _favouritedMeals.add(
          dummyMeals.firstWhere((meal) => mealId == meal.id),
        );
      });
    }
  }

  bool _isMealFavourited(String id) {
    return _favouritedMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Yummies",
        theme: ThemeData(
          accentColor: const Color.fromARGB(255, 240, 228, 121),
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.cyan[900],
              secondary: const Color.fromARGB(255, 165, 154, 4)),
          fontFamily: 'raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyMedium: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                bodyLarge: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                  fontSize: 25,
                ),
                titleMedium: const TextStyle(
                  fontSize: 24,
                  fontFamily: 'RobotoCondensed',
                ),
              ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => TabsScreen(_favouritedMeals),
          CategoriesMealScreen.routeName: (ctx) =>
              CategoriesMealScreen(_availableMeals),
          MealDetailsScreen.routeName: (ctx) =>
              MealDetailsScreen(toggleFavourite, _isMealFavourited),
          FilterScreen.routeName: (ctx) => FilterScreen(_filter, _setFilters)
        },
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => CategoriesScreen(),
          );
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => CategoriesScreen(),
          );
        });
  }
}

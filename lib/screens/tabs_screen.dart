// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/favouritees_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favouritedMeals;

  const TabsScreen(this.favouritedMeals);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, dynamic>>? _tabs;
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _tabs = [
      {
        'page': CategoriesScreen(),
        'title': "Yummis meals",
      },
      {
        //you can't use widget.favouriteMeals here when we intialize the class so we use initState( instead)
        'page': FavouritesScreen(widget.favouritedMeals),
        'title': "yummis Favourites",
      }
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: const MainDrawer(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            _tabs![_selectedPageIndex]['title'],
            style: TextStyle(
              fontFamily: 'RobotoCondensed',
              color: Theme.of(context).colorScheme.primary,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.primary,
          ),

          // bottom: const TabBar(
          //   tabs: [
          //     Tab(
          //       icon: Icon(
          //         Icons.home,
          //       ),
          //       text: "Home",
          //     ),
          //     Tab(
          //       icon: Icon(Icons.star_border),
          //       text: "Favorites",
          //     ),
          //   ],
          // ),
        ),
        body: _tabs![_selectedPageIndex]['page'],
        // TabBarView(
        //   children: [CategoriesScreen(), FavouritesScreen()],
        // ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.secondary,
          selectedItemColor: const Color.fromARGB(255, 240, 228, 121),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedLabelStyle: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).colorScheme.primary,
              icon: const Icon(
                Icons.home,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).colorScheme.primary,
              icon: const Icon(
                Icons.star_border,
              ),
              label: "Favorites",
            ),
          ],
        ),
      ),
    );
  }
}

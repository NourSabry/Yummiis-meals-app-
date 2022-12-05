// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = 'filterScreen';
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  const FilterScreen(
    this.currentFilters,
    this.saveFilters,
  );

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _isVegan = false;
  var _isVegeterian = false;
  var _isGluteenFree = false;
  var _isLactoseFree = false;

  @override
  void initState() {
    _isGluteenFree = widget.currentFilters['gluten']!;
    _isLactoseFree = widget.currentFilters['lactose']!;

    _isVegeterian = widget.currentFilters['vegetarian']!;

    _isVegan = widget.currentFilters['vegan']!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildSwitchListTile(
      String? title,
      String? description,
      bool? value,
      Function(bool)? onChanged,
    ) {
      return SwitchListTile(
        value: value!,
        onChanged: onChanged,
        title: Text(
          title!,
          style: const TextStyle(
            fontFamily: 'Raleway',
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          description!,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Filter Screen",
          ),
        ),
        drawer: const MainDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Adjust your meal selection",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchListTile(
                    "Gluten Free",
                    "Show meals only with gluteen free",
                    _isGluteenFree,
                    (bool value) {
                      setState(() {
                        _isGluteenFree = value;
                      });
                    },
                  ),
                  _buildSwitchListTile(
                    "Lactose Free",
                    "Show meals only with lactose free",
                    _isLactoseFree,
                    (bool newValue) {
                      setState(() {
                        _isLactoseFree = newValue;
                      });
                    },
                  ),
                  _buildSwitchListTile(
                    "Vegan meals",
                    "Show Vegan meals only",
                    _isVegan,
                    (bool newValue2) {
                      setState(() {
                        _isVegan = newValue2;
                      });
                    },
                  ),
                  _buildSwitchListTile(
                    "Vegeterian meals",
                    "Show Vegan meals only",
                    _isVegeterian,
                    (bool newValue3) {
                      setState(() {
                        _isVegeterian = newValue3;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: TextButton(
                          onPressed: () {
                            final selectedFilters = {
                              'gluten': _isGluteenFree,
                              'lactose': _isLactoseFree,
                              'vegan': _isVegan,
                              'vegetarian': _isVegeterian,
                            };
                            widget.saveFilters(selectedFilters);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                content: const Text(
                                  "Filters are applied to your meals now",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Save Changes ",
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.7),
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

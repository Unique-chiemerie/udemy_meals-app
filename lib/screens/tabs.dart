import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_app2/provider/meals_provider.dart';
import 'package:udemy_app2/models/meal.dart';
import 'package:udemy_app2/screens/Categories.dart';
import 'package:udemy_app2/screens/filters.dart';
import 'package:udemy_app2/screens/meals.dart';
import 'package:udemy_app2/widgets/main_drawer.dart';

const KInitialfilters = {
  Filter.glutenFree: false,
  Filter.lactosefree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class Tabscreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<Tabscreen> createState() => _TabscreenState();
}

class _TabscreenState extends ConsumerState<Tabscreen> {
  int _selectedpageIndex = 0;
  final List<Meal> _favouriteMeals = [];
  Map<Filter, bool> _selectedFilters = KInitialfilters;

  void _showinfomessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavouritestatus(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favouriteMeals.remove(meal);
      });
      _showinfomessage('meal is no longer a favourite');
    } else {
      setState(() {
        _favouriteMeals.add(meal);
      });
      _showinfomessage('marked as a Favourite');
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedpageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => Filterscreen(
            currentFilters: _selectedFilters,
          ),
        ),
      );
      setState(() {
        _selectedFilters = result ?? KInitialfilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealProvider);
    final availableMeals = meals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactosefree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    Widget activepage = CategoriesScreen(
      availableMeals: availableMeals,
      ontoggleFavourite: _toggleMealFavouritestatus,
    );
    var activepagetitle = 'categories';

    if (_selectedpageIndex == 1) {
      activepage = Mealscreen(
        ontoggleFavourite: _toggleMealFavouritestatus,
        meals: _favouriteMeals,
      );
      activepagetitle = 'your favourites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activepagetitle),
      ),
      drawer: mainDrawer(
        onselectScreen: _setScreen,
      ),
      body: activepage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedpageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'favourites')
        ],
      ),
    );
  }
}

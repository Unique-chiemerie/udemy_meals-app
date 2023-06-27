import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_app2/screens/Categories.dart';
import 'package:udemy_app2/screens/filters.dart';
import 'package:udemy_app2/screens/meals.dart';
import 'package:udemy_app2/widgets/main_drawer.dart';
import 'package:udemy_app2/provider/favourites_provider.dart';
import 'package:udemy_app2/provider/filters_provider.dart';

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

  void _selectPage(int index) {
    setState(() {
      _selectedpageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const Filterscreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filterMealsProvider);
    Widget activepage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activepagetitle = 'categories';

    if (_selectedpageIndex == 1) {
      final favouriteMeals = ref.watch(favuoritesMealProvider);
      activepage = Mealscreen(
        meals: favouriteMeals,
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

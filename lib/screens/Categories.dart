import 'package:flutter/material.dart';
import 'package:udemy_app2/data/dummy_data.dart';
import 'package:udemy_app2/models/Category.dart';
import 'package:udemy_app2/models/meal.dart';
import 'package:udemy_app2/screens/meals.dart';
import 'package:udemy_app2/widgets/Category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key,
      required this.ontoggleFavourite,
      required this.availableMeals});
  final void Function(Meal meal) ontoggleFavourite;
  final List<Meal> availableMeals;

  void _selectCateory(BuildContext, Category category) {
    final Filteredmeals = availableMeals
        .where((Meal) => Meal.categories.contains(category.id))
        .toList();
    Navigator.push(
        BuildContext,
        MaterialPageRoute(
          builder: (context) => Mealscreen(
            meals: Filteredmeals,
            title: category.title,
            ontoggleFavourite: ontoggleFavourite,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        //alternative to availableCategories.map((category)=>CategoryGridItem(category:category))
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onselectCategory: () {
              _selectCateory(context, category);
            },
          )
      ],
    );
  }
}

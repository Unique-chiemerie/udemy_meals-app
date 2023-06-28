import 'package:flutter/material.dart';
import 'package:udemy_app2/data/dummy_data.dart';
import 'package:udemy_app2/models/Category.dart';
import 'package:udemy_app2/models/meal.dart';
import 'package:udemy_app2/screens/meals.dart';
import 'package:udemy_app2/widgets/Category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCateory(BuildContext, Category category) {
    final Filteredmeals = widget.availableMeals
        .where((Meal) => Meal.categories.contains(category.id))
        .toList();
    Navigator.push(
        BuildContext,
        MaterialPageRoute(
          builder: (context) => Mealscreen(
            meals: Filteredmeals,
            title: category.title,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
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
              ),
          ],
        ),
        builder: (context, child) => SlideTransition(
              position: Tween(
                begin: const Offset(0, 0.3),
                end: const Offset(0, 0),
              ).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.easeInOut,
                ),
              ),
              child: child,
            ));
  }
}

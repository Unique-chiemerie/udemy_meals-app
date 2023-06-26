import 'package:udemy_app2/screens/meal_details.dart';

import 'package:flutter/material.dart';
import 'package:udemy_app2/models/meal.dart';
import 'package:udemy_app2/widgets/meal_item.dart';

class Mealscreen extends StatelessWidget {
  const Mealscreen(
      {super.key,
      required this.meals,
      this.title,
      required this.ontoggleFavourite});
  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) ontoggleFavourite;
  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealDetailsScreen(
          ontoggleFavourite: ontoggleFavourite,
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) => MealItem(
              meal: meals[index],
              onselectMeal: (meal) {
                selectMeal(context, meal);
              },
            ));
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('uh ohh...... nothing here!',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    )),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Try selecting a different category',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            )
          ],
        ),
      );
    }
    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}

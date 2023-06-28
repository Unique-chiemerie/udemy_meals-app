import 'package:flutter/material.dart';
import 'package:udemy_app2/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:udemy_app2/widgets/meal_item_trait.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onselectMeal});
  final Meal meal;
  final void Function(Meal meal) onselectMeal;

  String get ComplexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  String get complexitiyText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onselectMeal(meal);
        },
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(meal.imageUrl)),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemtrait(
                            icon: Icons.schedule,
                            label: '${meal.duration} min'),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemtrait(
                            icon: Icons.attach_money,
                            label: '$affordabilityText'),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemtrait(
                            icon: Icons.work, label: '$complexitiyText'),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

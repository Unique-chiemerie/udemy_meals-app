import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_app2/models/meal.dart';

class FavouritemealsNotifier extends StateNotifier<List<Meal>> {
  FavouritemealsNotifier() : super([]);

  bool toggleMealFavouritestatus(Meal meal) {
    final mealIsfavourite = state.contains(meal);
    if (mealIsfavourite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favuoritesMealProvider =
    StateNotifierProvider<FavouritemealsNotifier, List<Meal>>(((ref) {
  return FavouritemealsNotifier();
}));

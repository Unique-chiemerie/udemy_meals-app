import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_app2/data/dummy_data.dart';
import 'package:udemy_app2/screens/meals.dart';

final mealProvider = Provider((ref) {
  return dummyMeals;
});

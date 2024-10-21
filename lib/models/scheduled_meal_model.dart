import 'package:pantry/models/meal_time_model.dart';
import 'package:pantry/models/meals_model.dart';

class ScheduledMeal {
  MealTime mealTime;
  Meal? selectedMeal;
  double? servings;
  DateTime? date;
  String? note;

  ScheduledMeal({
    required this.mealTime,
    required this.selectedMeal,
    required this.servings,
    required this.date,
    this.note,
  });
}
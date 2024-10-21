import 'package:flutter/material.dart';
import 'package:pantry/models/meals_model.dart';

class MealsStorage extends ChangeNotifier {
  List<Meal> _meals = [];
  List<Meal> get meals => _meals;

  void addMeal (Meal meal) {
    _meals.add(meal);
    notifyListeners();
  }

  void removeMeal (String id) {
    _meals.removeWhere((m) => m.id == id);
    notifyListeners();
  }

  void updateMeal (Meal updatedMeal) {
    final index = _meals.indexWhere((meal) => meal.id == updatedMeal.id);
    if (index != -1) {
      _meals[index] = updatedMeal;
      notifyListeners();
    }
  }

  Meal getMealById(String id) {
    return _meals.firstWhere((meal) => meal.id == id);
  }

  void downloadRecipe(Meal downloadedMeal) {
    final List<MealIngredient> ingredientsWithZeroQuantity = downloadedMeal.mealIngredients.map((mealIngredient) {
      return MealIngredient(
        ingredient: mealIngredient.ingredient.copyWith(),
        quantity: 0,
      );
    }).toList();
    final newMeal = downloadedMeal.copyWith(mealIngredients: ingredientsWithZeroQuantity);
    _meals.add(newMeal);
  }
}
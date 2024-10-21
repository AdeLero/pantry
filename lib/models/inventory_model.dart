import 'package:flutter/material.dart';
import 'package:pantry/models/ingredients_model.dart';
import 'package:pantry/models/meal_schedule_storage.dart';

class Inventory extends ChangeNotifier {
  List<Ingredient> _ingredients = [];
  List<Ingredient> get ingredients => _ingredients;

  void addIngredient(Ingredient ingredient) {
    _ingredients.add(ingredient);
    notifyListeners();
  }

  void removeIngredient(String id) {
    _ingredients.removeWhere((ingredient) => ingredient.id == id);
    notifyListeners();
  }

  void updateIngredient(Ingredient updatedIngredient) {
    final index = _ingredients.indexWhere((ing) => ing.id == updatedIngredient.id);
    if (index != -1) {
      _ingredients[index] = updatedIngredient;
      notifyListeners();
    }
  }

  void updateIngredientQuantity(MealSchedule mealSchedule) {
    for (var scheduledMeal in mealSchedule.finalPlan) {
      final meal = scheduledMeal.selectedMeal;
      if (meal !=null) {
        final servings = scheduledMeal.servings ?? 1;
        for (var ingredient in meal.mealIngredients) {
          double requiredQuantity = ingredient.quantity * servings;
          final index = _ingredients.indexWhere((ing) => ing.id == ingredient.ingredient.id);
          if (index !=1) {
            _ingredients[index].quantity -= requiredQuantity;
          }
        }
      }
    }
    notifyListeners();
  }

  void addIngredientQuantity(Ingredient ingredient, double quantity) {
    final index = _ingredients.indexWhere((ing) => ing.id == ingredient.id);
    if (index != -1) {
      ingredients[index].quantity += quantity;
    } else {
      ingredients.add(ingredient.copyWith());
    }
    notifyListeners();
  }

  Ingredient getIngredientById(String id) {
    return _ingredients.firstWhere((ingredient) => ingredient.id == id);
  }


}
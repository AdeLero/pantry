import 'package:flutter/material.dart';
import 'package:pantry/models/inventory_model.dart';
import 'package:pantry/models/scheduled_meal_model.dart';
import 'package:provider/provider.dart';

class MealSchedule extends ChangeNotifier {
  List<ScheduledMeal> _tempPlan = [];
  List<ScheduledMeal> _finalPlan = [];

  List<ScheduledMeal> get tempPlan => _tempPlan;
  List<ScheduledMeal> get finalPlan => _finalPlan;


  void addScheduledMealToTempPlan(ScheduledMeal scheduledMeal) {
    _tempPlan.add(scheduledMeal);
    notifyListeners();
  }

  void removeScheduledMealFromTempPlan(ScheduledMeal scheduledMeal) {
    _tempPlan.remove(scheduledMeal);
    notifyListeners();
  }

  void deleteScheduledMeal (ScheduledMeal scheduledMeal, Inventory inventory) {
    final servings = scheduledMeal.servings ?? 1;
    for (var ingredient in scheduledMeal.selectedMeal!.mealIngredients) {
      inventory.addIngredientQuantity(ingredient.ingredient, ingredient.quantity * servings);
    }
    finalPlan.remove(scheduledMeal);
    notifyListeners();
  }

  void finalizePlan(BuildContext context) {
    _finalPlan.addAll(_tempPlan);
    _tempPlan.clear();

    final inventory = Provider.of<Inventory>(context, listen: false);
      inventory.updateIngredientQuantity(this);
    notifyListeners();
    inventory.notifyListeners();
  }

}

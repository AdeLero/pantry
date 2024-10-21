import 'package:flutter/material.dart';
import 'package:pantry/models/inventory_model.dart';
import 'package:pantry/models/meal_schedule_storage.dart';
import 'package:pantry/models/meals_storage.dart';
import 'package:pantry/models/shopping_settings_model.dart';
import 'package:pantry/models/shopping_trip_model.dart';
import 'package:provider/provider.dart';

class ShoppingLists extends ChangeNotifier {
  List<ShoppingTrip> shoppingTrips = [];
  List<ShoppingTrip> tempShoppingTrips = [];
  Map<String, double> neededIngredients = {};
  List<ShoppingIngredients> shoppingList = [];

  void generateShoppingList (BuildContext context, bool isCriticalQuantityIncluded) {
    neededIngredients.clear();
    shoppingList.clear();
    final frequency = Provider.of<ShoppingTripSettingsModel>(context, listen: false).selectedFrequency;
    DateTime now = DateTime.now();
    DateTime endDate;
    switch (frequency) {
      case 'Weekly':
        endDate = now.add(Duration(days: 7));
        break;
      case 'Fortnightly':
        endDate = now.add(Duration(days: 14));
        break;
      case 'Monthly':
        endDate = now.add(Duration(days: 30));
        break;
      default:
        endDate = now.add(Duration(days: 7));
        break;
    }
    final inventory = Provider.of<Inventory>(context, listen: false);
    final scheduledMeals =
        Provider.of<MealSchedule>(context, listen: false).finalPlan;

    for (var scheduledMeal in scheduledMeals) {
      DateTime mealDate = scheduledMeal.date!;
      if (mealDate.isAfter(now) && mealDate.isBefore(endDate)){
        final meal = Provider.of<MealsStorage>(context, listen: false)
            .getMealById(scheduledMeal.selectedMeal!.id);
        for (var mealIngredient in meal.mealIngredients) {
          neededIngredients.update(
            mealIngredient.ingredient.id,
                (value) => value + mealIngredient.quantity,
            ifAbsent: () => mealIngredient.quantity,
          );
        }
      }
      if (isCriticalQuantityIncluded) {
        includeCriticalQuantity(context);
      }
    }
    for (var ingredient in inventory.ingredients) {
      if (neededIngredients.containsKey(ingredient.id)) {
        double totalNeeded = neededIngredients[ingredient.id]!;
        double deficit = totalNeeded - ingredient.quantity;
        if (deficit > 0) {
          shoppingList.add(ShoppingIngredients(ingredient: ingredient.copyWith(), quantity: deficit));
        }
      }
    }
    notifyListeners();
  }

  void includeCriticalQuantity(BuildContext context) {
    final inventory = Provider.of<Inventory>(context, listen: false);
    for (var ingredient in inventory.ingredients) {
      if (ingredient.isCritical) {
        double neededAmount =
            (ingredient.criticalQuantity! + 1) - ingredient.quantity;
        shoppingList.add(
          ShoppingIngredients(ingredient: ingredient.copyWith(), quantity: neededAmount),
        );
      }
    }
  }

  void saveShoppingList(int index) {
    final trip = tempShoppingTrips[index];
    shoppingTrips.add(trip);
    tempShoppingTrips.removeAt(index);
    notifyListeners();
  }

  void saveTempShoppingList() {
    final DateTime today = DateTime.now();
    shoppingTrips.add(ShoppingTrip(date: today, shoppingIngredients: shoppingList));
    shoppingList.clear();
    notifyListeners();
  }

  void discardTempShoppingList(int index) {
    tempShoppingTrips.removeAt(index);
    notifyListeners();
  }

  ShoppingTrip getTripbyId (String id) {
    return shoppingTrips.firstWhere((trip) => trip.id == id);
  }
}

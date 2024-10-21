import 'package:pantry/models/ingredients_model.dart';
import 'package:uuid/uuid.dart';

class MealIngredient{
  final Ingredient ingredient;
  double quantity;

  MealIngredient({
    required this.ingredient,
    required this.quantity,
});
  MealIngredient copyWith({
    Ingredient? ingredient,
    double? quantity,
}) {
    return MealIngredient(
      ingredient: ingredient ?? this.ingredient,
      quantity: quantity ?? this.quantity,
    );
  }
}

class Meal {
  String id;
  String mealName;
  List<MealIngredient> mealIngredients;
  String? image;
  String? howToCook;
  String? timeToCook;

  Meal({
    required this.mealName,
    required this.mealIngredients,
    String? id,
    this.image,
    this.howToCook,
    this.timeToCook,
  }) : id = const Uuid().v4();

  Meal copyWith({
    String? id,
    String? mealName,
    List<MealIngredient>? mealIngredients,
    String? image,
    String? howToCook,
    String? timeToCook,
}) {
    return Meal(
      id: id ?? this.id,
      mealName: mealName ?? this.mealName,
      mealIngredients: mealIngredients ?? this.mealIngredients,
      image: image ?? this.image,
      howToCook: howToCook ?? this.howToCook,
      timeToCook: timeToCook ?? this.timeToCook,
    );
  }
}
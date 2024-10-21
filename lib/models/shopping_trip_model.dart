import 'package:pantry/models/ingredients_model.dart';
import 'package:uuid/uuid.dart';

class ShoppingIngredients {
  Ingredient ingredient;
  double quantity;

  ShoppingIngredients({
    required this.ingredient,
    required this.quantity,
  });
}

class ShoppingTrip {
  DateTime date;
  List<ShoppingIngredients> shoppingIngredients;
  String id;

  ShoppingTrip({
    required this.date,
    required this.shoppingIngredients,
    String? id,
  }) : id = const Uuid().v4();
}
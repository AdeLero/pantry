import 'package:uuid/uuid.dart';

class Ingredient {
  String id;
  String ingredientName;
  double quantity;
  double? criticalQuantity;
  String unitOfMeasurement;

  Ingredient({
    this.criticalQuantity,
    String? id,
    required this.ingredientName,
    required this.quantity,
    required this.unitOfMeasurement
  }) :  id = id ?? Uuid().v4();

  Ingredient copyWith({
   String? id,
   String? ingredientName,
   String? unitOfMeasurement,
   double? quantity,
}) {
    return Ingredient(
      id: this.id,
      ingredientName: ingredientName ?? this.ingredientName,
      unitOfMeasurement: unitOfMeasurement ?? this.unitOfMeasurement,
      quantity: quantity ?? this.quantity,
    );
  }
  bool get isCritical => criticalQuantity != null && quantity <= criticalQuantity!;
}
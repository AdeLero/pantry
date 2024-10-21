import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry/customization/custom_colors.dart';
import 'package:pantry/customization/simplify/pages.dart';
import 'package:pantry/models/ingredients_model.dart';
import 'package:pantry/models/inventory_model.dart';
import 'package:provider/provider.dart';

class IngredientListSelection extends StatelessWidget {
  final Function(Ingredient) onIngredientSelected;

  IngredientListSelection({required this.onIngredientSelected});

  @override
  Widget build(BuildContext context) {
    final inventory = Provider.of<Inventory>(context);
    final ingredients = inventory.ingredients;
    return Scaffold(
      body: SafeArea(
        child: ingredients.isNotEmpty
            ? Column(
                children: [
                  Container(
                    height: 40,
                    color: AppColors.deepGreen,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ingredients',
                          style: TextStyle(
                            color: AppColors.baseWhite,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Qty',
                          style: TextStyle(
                            color: AppColors.baseWhite,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: ingredients.length,
                      itemBuilder: (context, index) {
                        final ingredient = ingredients[index];
                        return GestureDetector(
                          onTap: () {
                            onIngredientSelected(ingredient);
                          },
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 28),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ingredient.ingredientName,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                          color: ingredient.isCritical
                                              ? AppColors.lightRed
                                              : AppColors.lightGreen,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        '${ingredient.quantity} ${ingredient.unitOfMeasurement}',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            : Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 230,
                        width: 230,
                        child: Image.asset(
                            'lib/customization/assets/images/no_ingredients.png'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'You Have Not Created Any Ingredient Yet',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Get.toNamed(Routes.AddIngredient);
                        },
                        child: Text(
                          'Create Ingredients Now',
                        ),
                        style: ButtonStyle(
                          foregroundColor:
                              WidgetStatePropertyAll(AppColors.deepGreen),
                          overlayColor:
                              WidgetStatePropertyAll(AppColors.deepGreen),
                          fixedSize: WidgetStatePropertyAll(
                            Size(320, 40),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pantry/customization/custom_colors.dart';
import 'package:pantry/customization/simplify/pages.dart';
import 'package:pantry/models/inventory_model.dart';
import 'package:provider/provider.dart';

class IngredientListEditable extends StatelessWidget {
  const IngredientListEditable({super.key});

  @override
  Widget build(BuildContext context) {
    final inventory = Provider.of<Inventory>(context);
    final ingredients = inventory.ingredients;
    return ingredients.isNotEmpty
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
              return Slidable(
                key: Key(ingredient.ingredientName),
                startActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                          onPressed: (context) {
                            Get.toNamed(Routes.EditIngredient, arguments: ingredient.id);
                          },
                        backgroundColor: AppColors.deepGreen,
                        foregroundColor: AppColors.lightGreen,
                        icon: Icons.edit_outlined,
                      ),
                    ]
                ),
                endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          inventory.removeIngredient(ingredient.id);
                        },
                        backgroundColor: AppColors.deepRed,
                        foregroundColor: AppColors.lightRed,
                        icon: Icons.delete_outline_rounded,
                      ),
                    ]
                ),
                child: Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 28),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                color: ingredient.isCritical ? AppColors.lightRed : AppColors.lightGreen,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            SizedBox(width: 30,),
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
              );          },
          ),
        ),
      ],
    )
    : Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 180,
              height: 180,
              child: Image.asset(
                'lib/customization/assets/images/no_ingredients.png',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'You do not have any Ingredients',
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        ElevatedButton(
            onPressed: () {
              Get.toNamed(Routes.AddIngredient);
            },
            child: Text(
              'Create Ingredient',
            ),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.deepGreen),
            foregroundColor: WidgetStatePropertyAll(AppColors.baseWhite),
            fixedSize: WidgetStatePropertyAll(
              Size (320,40),
            ),
          ),
        ),
      ],
    );
  }
}

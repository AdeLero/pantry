import 'package:flutter/material.dart';
import 'package:pantry/customization/custom_colors.dart';
import 'package:pantry/models/inventory_model.dart';
import 'package:provider/provider.dart';

class IngredientListMini extends StatelessWidget {
  const IngredientListMini({super.key});

  @override
  Widget build(BuildContext context) {
    final ingredients = Provider.of<Inventory>(context).ingredients;
    return Column(
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal:20),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                final ingredient = ingredients[index];
                return Container(
                  width: 320,
                  padding: EdgeInsets.symmetric(vertical: 8),
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
                );          },
            ),
          ),
        ),
      ],
    );
  }
}

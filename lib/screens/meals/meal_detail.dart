import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pantry/customization/custom_colors.dart';
import 'package:pantry/models/meals_model.dart';
import 'package:pantry/models/meals_storage.dart';
import 'package:provider/provider.dart';

class MealDetail extends StatelessWidget {
  final String mealId;
  const MealDetail({required this.mealId});

  @override
  Widget build(BuildContext context) {
    final mealStorage = Provider.of<MealsStorage>(context, listen: false);
    final meal = mealStorage.getMealById(mealId);
    return Scaffold(
      body: Stack(
        children: [
          Image.file(
            height: 500,
            File(meal.image!),
            fit: BoxFit.cover,
          ),
          SafeArea(
              child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: FaIcon(FontAwesomeIcons.arrowLeft),
              color: AppColors.baseWhite,
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: FaIcon(FontAwesomeIcons.shareFromSquare),
                color: AppColors.baseWhite,
              ),
              IconButton(
                onPressed: () {},
                icon: FaIcon(FontAwesomeIcons.heart),
                color: AppColors.baseWhite,
              )
            ],
          )),
          Positioned(
            top: 450,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: AppColors.baseWhite,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 200,
                          height: 96,
                          child: Text(
                            meal.mealName,
                            style: TextStyle(
                              color: AppColors.deepGreen,
                              fontWeight: FontWeight.w900,
                              fontSize: 35,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_outlined,
                                  color: AppColors.faintGrey,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  meal.timeToCook!,
                                  style: TextStyle(
                                    color: AppColors.faintGrey,
                                    fontSize: 15,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                Text(
                                  'Mins',
                                  style: TextStyle(
                                    color: AppColors.faintGrey,
                                    fontSize: 15,
                                    fontStyle: FontStyle.italic,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 10,),
                            OutlinedButton(
                              style: ButtonStyle(
                                foregroundColor: WidgetStatePropertyAll(AppColors.deepGreen),
                              ),
                                onPressed: () {},
                                child: Text('Download'),
                            )
                          ],
                        ),
                      ],
                    ),
                    Text(
                      'By Username',
                      style: TextStyle(
                        color: AppColors.faintGrey,
                        fontStyle: FontStyle.italic,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'What you need',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: meal.mealIngredients.length,
                            itemBuilder: (BuildContext context, int index) {
                              final mealIngredient = meal.mealIngredients[index];
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                    Text(mealIngredient.ingredient.ingredientName),
                                    Text(
                                      '${mealIngredient.quantity.toString()} ${mealIngredient.ingredient.unitOfMeasurement}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                ],
                              );
                            }
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How to Cook',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          meal.howToCook!,
                          style: TextStyle(
                            fontSize: 15,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

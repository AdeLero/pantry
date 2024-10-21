import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry/customization/custom_colors.dart';
import 'package:pantry/customization/simplify/pages.dart';
import 'package:pantry/models/meals_storage.dart';
import 'package:provider/provider.dart';

class MealListSelection extends StatelessWidget {
  final Function onMealSelected;
  MealListSelection({required this.onMealSelected});

  @override
  Widget build(BuildContext context) {
    final mealStorage = Provider.of<MealsStorage>(context);
    final meals = mealStorage.meals;
    return Scaffold(
      body: SafeArea(
        child: meals.isNotEmpty
            ? ListView.builder(
                itemCount: meals.length,
                itemBuilder: (BuildContext context, int index) {
                  final meal = meals[index];
                  return GestureDetector(
                    onTap: () {
                        onMealSelected(meal);
                    },
                    child: Stack(
                      children: [
                        meal.image != null
                            ? Image.file(
                                File(meal.image!),
                                height: 150,
                                width: double.maxFinite,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                height: 150,
                                color: AppColors.lightGreen,
                              ),
                        Positioned(
                          bottom: 0,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20, bottom: 15),
                            child: SizedBox(
                              width: 250,
                              child: Text(
                                meal.mealName,
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.baseWhite,
                                  decorationThickness: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                })
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 180,
                          height: 180,
                          child: Image.asset(
                            'lib/customization/assets/images/no_meals_planned.png',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'You do not have any Meals',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.CreateMeal);
                      },
                      child: Text(
                        'Create Meal Manually',
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(AppColors.deepGreen),
                        foregroundColor:
                            WidgetStatePropertyAll(AppColors.baseWhite),
                        fixedSize: WidgetStatePropertyAll(
                          Size(320, 40),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Download a recipe Online',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ButtonStyle(
                        foregroundColor:
                            WidgetStatePropertyAll(AppColors.deepGreen),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

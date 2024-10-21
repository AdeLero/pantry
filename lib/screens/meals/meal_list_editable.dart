import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:pantry/customization/custom_colors.dart';
import 'package:pantry/customization/simplify/pages.dart';
import 'package:pantry/models/meals_storage.dart';
import 'package:provider/provider.dart';

class MealListEditable extends StatelessWidget {
  const MealListEditable({super.key});

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
                  return Slidable(
                    startActionPane: ActionPane(
                        extentRatio: 0.25,
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              Get.toNamed(Routes.EditMeal, arguments: meal);
                            },
                            backgroundColor: AppColors.deepGreen,
                            foregroundColor: AppColors.lightGreen,
                            icon: Icons.edit_outlined,
                          ),
                        ]),
                    endActionPane: ActionPane(
                        extentRatio: 0.25,
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              Get.defaultDialog(
                                title: 'Delete Meal',
                                middleText:
                                    'Are you sure you want to delete this meal?',
                                textCancel: 'Cancel',
                                textConfirm: 'Delete',
                                confirmTextColor: AppColors.deepRed,
                                cancelTextColor: AppColors.deepGreen,
                                buttonColor: AppColors.baseWhite,
                                onConfirm: () {
                                  mealStorage.removeMeal(meal.id);
                                  Get.back();
                                },
                                onCancel: () {
                                  Get.back();
                                },
                              );
                            },
                            backgroundColor: AppColors.deepRed,
                            foregroundColor: AppColors.lightRed,
                            icon: Icons.delete_outline_rounded,
                          ),
                        ]),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          Routes.MealDetail, arguments: meal.id,
                        );
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

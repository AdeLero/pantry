import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pantry/customization/custom_colors.dart';
import 'package:pantry/customization/simplify/pages.dart';
import 'package:pantry/models/meal_schedule_storage.dart';
import 'package:pantry/models/meal_time_model.dart';
import 'package:provider/provider.dart';

class FinalizeMealSchedule extends StatelessWidget {
  const FinalizeMealSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    final mealSchedule = Provider.of<MealSchedule>(context);
    final tempPlan = mealSchedule.tempPlan;
    final finalPlan = mealSchedule.finalPlan;
    String getMealTimeString (MealTime mealTime) {
      switch (mealTime) {
        case MealTime.Breakfast:
          return 'Breakfast';
        case MealTime.Lunch:
          return 'Lunch';
        case MealTime.Dinner:
          return 'Dinner';
          default:
            return '';
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: FaIcon(
            FontAwesomeIcons.arrowLeft,
          ),
          iconSize: 24,
          color: AppColors.deepGreen,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              margin: EdgeInsets.only(bottom: 10),
              height: 90,
              width: 280,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Finalize your',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Meal Schedule',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            tempPlan.isNotEmpty
            ? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: tempPlan.length,
              itemBuilder: (BuildContext context, int index) {
                final tempMeal = tempPlan[index];
                final dateText = DateFormat('dd/MM').format(tempMeal.date!);
                return Slidable(
                  startActionPane: ActionPane(
                      extentRatio: 0.25,
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
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
                                tempPlan.remove(tempMeal);
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
                  child: Stack(
                    children: [
                      tempMeal.selectedMeal != null
                      ? Image.file(
                        File(
                          tempMeal.selectedMeal!.image!
                        ),
                        fit: BoxFit.cover,
                        width: double.maxFinite,
                        height: 200,
                      )
                      : SizedBox(),
                      Positioned(
                        bottom: 0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getMealTimeString(tempMeal.mealTime),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.baseWhite,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(0, 4),
                                      blurRadius: 4,
                                      color: Colors.black.withOpacity(0.25),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 215,
                                    child: Text(
                                      tempMeal.selectedMeal!.mealName,
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.baseWhite,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(0, 4),
                                            blurRadius: 4,
                                            color: Colors.black.withOpacity(0.25),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text(
                                    dateText,
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.baseWhite,
                                      shadows: [
                                        Shadow(
                                          offset: Offset(0, 4),
                                          blurRadius: 4,
                                          color: Colors.black.withOpacity(0.25),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ) : SizedBox(),
            ClipRRect(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.ScheduleMeal);
                      },
                      child: Text(
                        'Add Another Meal to your Schedule',
                        style: TextStyle(
                          color: AppColors.deepGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        mealSchedule.finalizePlan(context);
                        Get.offAllNamed(Routes.Landing);
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(AppColors.deepGreen),
                        foregroundColor: WidgetStatePropertyAll(AppColors.baseWhite),
                        fixedSize: WidgetStatePropertyAll(
                          Size(320, 40),
                        ),
                      ),
                      child: Text('Finalize Meal Schedule'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

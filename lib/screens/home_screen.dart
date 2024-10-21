import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pantry/customization/custom_colors.dart';
import 'package:pantry/customization/simplify/pages.dart';
import 'package:pantry/models/inventory_model.dart';
import 'package:pantry/models/meal_schedule_storage.dart';
import 'package:pantry/models/meal_time_model.dart';
import 'package:pantry/other_widgets/calendar_widget.dart';
import 'package:pantry/other_widgets/mealtime_countdown.dart';
import 'package:pantry/screens/ingredients/ingredient_list_mini.dart';
import 'package:pantry/screens/meal_time/meal_time_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mealPlanStorage = Provider.of<MealSchedule>(context);
    final inventory = Provider.of<Inventory>(context);
    final mealTime = Provider.of<MealTimeProvider>(context);
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
      body: SafeArea(
        child: mealPlanStorage.finalPlan.isNotEmpty || inventory.ingredients.isNotEmpty
            ? SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CalendarWidget(),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Username',
                  style: TextStyle(
                    color: AppColors.deepGreen,
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              MealtimeCountdown(
                  breakfastTime: mealTime.breakfastTime,
                  lunchTime: mealTime.lunchTime,
                  dinnerTime: mealTime.dinnerTime
              ),
              mealPlanStorage.finalPlan.isNotEmpty
              ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: mealPlanStorage.finalPlan.length,
                itemBuilder: (BuildContext context, int index) {
                  final scheduledMeal = mealPlanStorage.finalPlan[index];
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
                                  mealPlanStorage.deleteScheduledMeal(scheduledMeal, inventory);
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
                        scheduledMeal.selectedMeal != null
                            ? Image.file(
                          File(
                              scheduledMeal.selectedMeal!.image!
                          ),
                          fit: BoxFit.cover,
                          width: double.maxFinite,
                          height: 200,
                        )
                            : SizedBox(),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: FaIcon(
                                  FontAwesomeIcons.shareFromSquare,
                                  size: 24,
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
                              IconButton(
                                onPressed: () {},
                                icon: FaIcon(
                                  FontAwesomeIcons.heart,
                                  size: 24,
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
                        ),
                        Positioned(
                          bottom: 0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getMealTimeString(scheduledMeal.mealTime),
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
                                SizedBox(
                                  width: 215,
                                  child: Text(
                                    scheduledMeal.selectedMeal!.mealName,
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
              : Center(
                child: Container(
                  width: 320,
                  height: 300,
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 150,
                        height: 150,
                        child: Image.asset(
                          'lib/customization/assets/images/no_scheduled_meals.png'
                        ),
                      ),
                      Text(
                        'You Have Not Scheduled Any Meals for this day',
                      ),
                      OutlinedButton(
                          onPressed: () {
                            Get.toNamed(Routes.ScheduleMeal);
                          },
                          child: Text(
                            'Schedule Meals Now',
                          ),
                        style: ButtonStyle(
                          foregroundColor: WidgetStatePropertyAll(AppColors.deepGreen),
                          fixedSize: WidgetStatePropertyAll(
                            Size(320, 40),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              inventory.ingredients.isNotEmpty
              ? Container(
                height: 170,
                child: IngredientListMini(),
              )
                  : Container(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    'Plan A Shopping Trip',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColors.deepGreen),
                    foregroundColor: WidgetStatePropertyAll(AppColors.baseWhite),
                    fixedSize: WidgetStatePropertyAll(Size(305,40)),
                  ),
                ),
              ),
            ],
          ),
        )
            :
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 230,
                  width: 230,
                  child: Image.asset(
                      'lib/customization/assets/images/no_scheduled_meals.png'),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'You Have Not Planned any Meals Yet',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
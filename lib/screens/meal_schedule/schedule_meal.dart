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
import 'package:pantry/models/meals_model.dart';
import 'package:pantry/models/scheduled_meal_model.dart';
import 'package:pantry/other_widgets/calendar.dart';
import 'package:pantry/screens/meals/meal_list_selection.dart';
import 'package:provider/provider.dart';

class ScheduleMeals extends StatefulWidget {
  const ScheduleMeals({super.key});

  @override
  State<ScheduleMeals> createState() => _ScheduleMealsState();
}

class _ScheduleMealsState extends State<ScheduleMeals> {
  final List<MealTime> mealTimes = [
    MealTime.Breakfast,
    MealTime.Lunch,
    MealTime.Dinner,
  ];
  MealTime _selectedMealTime = MealTime.Breakfast;
  Meal? _selectedMeal;
  late String _dateText;
  @override
  void initState() {
    super.initState();
    _dateText = DateFormat('dd/MM/yyyy (E)').format(DateTime.now());
  }

  DateTime? selectedDay = DateTime.now();
  void _showCalendar() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Calendar(onDaySelected: (date) {
            if (date != null) {
              setState(() {
                selectedDay = date;
                _dateText = DateFormat('dd/MM/yyyy (E)').format(date);
              });
            }
            Get.back();
          });
        });
  }

  final TextEditingController quantityController =
      TextEditingController(text: '1');
  void _updateQuantity(int delta) {
    setState(() {
      int quantity = int.parse(quantityController.text);
      quantity += delta;
      if (quantity < 1) quantity = 1;
      quantityController.text = quantity.toString();
    });
  }

  void _createScheduledMeal() {
    final mealTime = _selectedMealTime;
    final selectedMeal = _selectedMeal;
    double servings = double.parse(quantityController.text);
    final date = selectedDay;

    ScheduledMeal newMeal = ScheduledMeal(
        mealTime: mealTime,
        selectedMeal: selectedMeal,
        servings: servings,
        date: date);

    final scheduledMealsList =
        Provider.of<MealSchedule>(context, listen: false);
    scheduledMealsList.tempPlan.add(newMeal);

    _selectedMeal = null;
    selectedDay = null;
    quantityController.clear();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 90,
                width: 230,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Schedule A',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Meal',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'What Time is the meal?',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(mealTimes.length, (index) {
                  final mealTime = mealTimes[index];
                  final _isSelected = _selectedMealTime == mealTime;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedMealTime = mealTime;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          bottom: 25, top: 10, left: 10, right: 10),
                      width: 75,
                      height: 45,
                      decoration: BoxDecoration(
                        color: _isSelected
                            ? AppColors.deepGreen
                            : AppColors.lightGreen,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          mealTime.toString().split('.').last,
                          style: TextStyle(
                            color: _isSelected
                                ? AppColors.baseWhite
                                : AppColors.deepGreen,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              Text(
                'What Meal is it?',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              _selectedMeal == null
                  ? GestureDetector(
                      onTap: () {
                        Get.to(() =>
                            MealListSelection(onMealSelected: (selectedMeal) {
                              setState(() {
                                _selectedMeal = selectedMeal;
                              });
                              Get.back();
                            }));
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        width: 320,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.deepGreen,
                          ),
                        ),
                        child: Icon(
                          Icons.add,
                          size: 48,
                          color: AppColors.deepGreen,
                        ),
                      ),
                    )
                  : Slidable(
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
                                  setState(() {
                                    _selectedMeal = null;
                                  });
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
                        ],
                      ),
                      child: Image.file(
                        File(
                          _selectedMeal!.image!,
                        ),
                        height: 100,
                        width: 320,
                        fit: BoxFit.cover,
                      ),
                    ),
              SizedBox(
                height: 10,
              ),
              Text(
                'What Day?',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      _showCalendar();
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.calendar,
                    ),
                  ),
                  Text(_dateText),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'How Many Servings?',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      _updateQuantity(-1);
                    },
                    icon: Icon(
                      Icons.remove_circle_outline_outlined,
                      size: 24,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 50,
                    height: 15,
                    child: TextField(
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _updateQuantity(1);
                    },
                    icon: Icon(
                      Icons.add_circle_outline_outlined,
                      size: 24,
                    ),
                  ),
                ],
              ),
              _selectedMeal != null
                  ? Column(
                    children: [
                      Container(
                        height: 40,
                        color: AppColors.deepGreen,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
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
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: _selectedMeal?.mealIngredients.length,
                          itemBuilder: (BuildContext context, int index) {
                            final mealIngredient =
                                _selectedMeal?.mealIngredients[index];
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      mealIngredient!.ingredient.ingredientName,
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
                                              color: mealIngredient
                                                      .ingredient.isCritical
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
                                            '${mealIngredient.quantity * double.parse(quantityController.text)} ${mealIngredient.ingredient.unitOfMeasurement}',
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ));
                          },
                        ),
                    ],
                  )
                  : SizedBox(),
              ElevatedButton(
                onPressed: () {
                  _createScheduledMeal();
                  Get.toNamed(Routes.FinalizeMealSchedule);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.deepGreen),
                  foregroundColor: WidgetStatePropertyAll(AppColors.baseWhite),
                  fixedSize: WidgetStatePropertyAll(
                    Size(320, 40),
                  ),
                ),
                child: Text('Schedule Meal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

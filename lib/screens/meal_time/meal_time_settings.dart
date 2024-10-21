import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pantry/customization/custom_colors.dart';
import 'package:pantry/screens/meal_time/meal_time_provider.dart';
import 'package:provider/provider.dart';

class MealTimeSettings extends StatefulWidget {
  const MealTimeSettings({super.key});

  @override
  State<MealTimeSettings> createState() => _MealTimeSettingsState();
}

class _MealTimeSettingsState extends State<MealTimeSettings> {
  late TimeOfDay breakfastTime;
  late TimeOfDay lunchTime;
  late TimeOfDay dinnerTime;

  @override
  void initState() {
    super.initState();
    breakfastTime = TimeOfDay(hour: 8, minute: 0);
    lunchTime = TimeOfDay(hour: 14, minute: 0);
    dinnerTime = TimeOfDay(hour: 20, minute: 0);
  }

  Future<void> _selectTime(BuildContext context, TimeOfDay initialTime,
      Function(TimeOfDay) onTimeSelected) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: initialTime
    );

    if (picked != null && picked != initialTime) {
      onTimeSelected(picked);
    }
  }
  @override
  Widget _buildMealTimeRow(
      String label, TimeOfDay time, Function(TimeOfDay) onTimeSelected) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 2.5, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.lightGreen,
              border: Border.all(
                color: AppColors.deepGreen,
              )
          ),
          child: TextButton(
            onPressed: () => _selectTime(context, time, onTimeSelected),
            child: Text(
              time.format(context),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }


  Widget build(BuildContext context) {
    final mealTimeSettings = Provider.of<MealTimeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        elevation: 3,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 30, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What Time is...',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 32,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  _buildMealTimeRow('Breakfast', breakfastTime, (time) {
                    setState(() {
                      breakfastTime = time;
                    });
                  }),
                  SizedBox(
                    height: 100,
                  ),
                  _buildMealTimeRow('Lunch', lunchTime, (time) {
                    setState(() {
                      lunchTime = time;
                    });
                  }),
                  SizedBox(
                    height: 100,
                  ),
                  _buildMealTimeRow('Dinner', dinnerTime, (time) {
                    setState(() {
                      dinnerTime = time;
                    });
                  }),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () {
                  mealTimeSettings.setMealTimes(
                      breakfastTime: breakfastTime,
                      lunchTime: lunchTime,
                      dinnerTime: dinnerTime
                  );
                  Get.back();
                },
                child: Text(
                  'Set Mealtimes',
                  style: TextStyle(
                    color: AppColors.baseWhite,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.deepGreen),
                  fixedSize: WidgetStatePropertyAll(
                    Size(320, 40),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
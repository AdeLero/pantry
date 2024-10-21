import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pantry/customization/custom_colors.dart';
import 'package:pantry/screens/date/date_controller.dart';

class CalendarWidget extends StatelessWidget {
  final DateController dateController = Get.put(DateController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
          dateController.fiveDayrange.map((date) {
            bool isSelected = date.day == dateController.selectedDate.value.day &&
                date.month == dateController.selectedDate.value.month &&
                date.year == dateController.selectedDate.value.year;

            return GestureDetector(
              onTap: () {
                dateController.updateSelectedDate(date);
              },
              child: Container(
                width: 60,
                height: 70,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.deepGreen : AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      DateFormat.E().format(date),
                      style: TextStyle(
                        color: isSelected ? AppColors.lightGreen : AppColors.deepGreen,
                        fontSize: 10,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      DateFormat.d().format(date),
                      style: TextStyle(
                        color: isSelected ? AppColors.lightGreen : AppColors.deepGreen,
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      DateFormat.MMM().format(date),
                      style: TextStyle(
                        color: isSelected ? AppColors.lightGreen : AppColors.deepGreen,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        ),
      ],
    );
  }
}
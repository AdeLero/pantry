import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pantry/customization/custom_colors.dart';
import 'package:pantry/models/shopping_trip_provider.dart';
import 'package:pantry/other_widgets/calendar.dart';
import 'package:pantry/screens/shopping/temp_shopping_list.dart';
import 'package:provider/provider.dart';

class GenerateShoppingListBottomSheet extends StatefulWidget {
  const GenerateShoppingListBottomSheet({super.key});

  @override
  State<GenerateShoppingListBottomSheet> createState() => _GenerateShoppingListBottomSheetState();
}

class _GenerateShoppingListBottomSheetState extends State<GenerateShoppingListBottomSheet> {
  late String _dateText;
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
  bool isCriticalQuantityIncluded = false;
  @override
  Widget build(BuildContext context) {
    final shoppingTrips = Provider.of<ShoppingLists>(context, listen: false);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Generate Shopping List',
              style: TextStyle(
                color: AppColors.deepGreen,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(height: 70,),
            Text(
              'Shopping Date',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    _showCalendar();
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.calendar,
                  )
                ),
                Text(_dateText),
              ],
            ),
            SizedBox(height: 70,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    'Include Ingredients below Critical Quantity?',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Switch(
                  trackOutlineColor: WidgetStatePropertyAll(AppColors.deepGreen),
                  thumbColor: WidgetStatePropertyAll(AppColors.deepGreen),
                  activeColor: AppColors.lightGreen,
                  activeTrackColor: AppColors.lightGreen,
                  value: isCriticalQuantityIncluded,
                  onChanged: (bool value) {
                    setState(() {
                      isCriticalQuantityIncluded = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                shoppingTrips.generateShoppingList(context, isCriticalQuantityIncluded);
                shoppingTrips.saveTempShoppingList();
                String tripId = shoppingTrips.shoppingTrips.last.id;
                //Get.to(() => TempShoppingList(tripId: tripId));
                // Get to the list screen for the just generated Shopping List
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.deepGreen),
                foregroundColor: WidgetStatePropertyAll(AppColors.baseWhite),
                fixedSize: WidgetStatePropertyAll(Size(320,40),),
              ),
              child: Text(
                'Generate Shopping Lists',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

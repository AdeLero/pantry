import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry/customization/simplify/pages.dart';
import 'package:pantry/customization/simplify/routes.dart';
import 'package:pantry/models/inventory_model.dart';
import 'package:pantry/models/meal_schedule_storage.dart';
import 'package:pantry/models/meals_storage.dart';
import 'package:pantry/models/shopping_settings_model.dart';
import 'package:pantry/models/shopping_trip_provider.dart';
import 'package:pantry/screens/meal_time/meal_time_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Inventory(),
        ),
        ChangeNotifierProvider(
          create: (_) => MealsStorage(),
        ),
        ChangeNotifierProvider(
          create: (_) => MealSchedule(),
        ),
        ChangeNotifierProvider(
          create: (_) => MealTimeProvider(
            breakfastTime: TimeOfDay(hour: 8, minute: 0),
            lunchTime: TimeOfDay(hour: 14, minute: 0),
            dinnerTime: TimeOfDay(hour: 20, minute: 0),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ShoppingLists(),
        ),
        ChangeNotifierProvider(
          create: (_) => ShoppingTripSettingsModel(),
        ),
      ],
      child: const PantryApp(),
    ),
  );
}

class PantryApp extends StatelessWidget {
  const PantryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Routes.Splash,
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.routes,
      theme: ThemeData(fontFamily: 'Inter'),
    );
  }
}

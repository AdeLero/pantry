import 'package:get/get.dart';
import 'package:pantry/customization/simplify/pages.dart';
import 'package:pantry/other_widgets/calendar.dart';
import 'package:pantry/screens/account_screen.dart';
import 'package:pantry/screens/auth/sign_in_screen.dart';
import 'package:pantry/screens/auth/sign_up_screen.dart';
import 'package:pantry/screens/home_screen.dart';
import 'package:pantry/screens/ingredients/create_ingredient.dart';
import 'package:pantry/screens/ingredients/edit_ingredient.dart';
import 'package:pantry/screens/ingredients/ingredient_list_selection.dart';
import 'package:pantry/screens/landing_page.dart';
import 'package:pantry/screens/lists_screen.dart';
import 'package:pantry/screens/loading_screen.dart';
import 'package:pantry/screens/meal_schedule/finalize_meal_schedule.dart';
import 'package:pantry/screens/meal_schedule/schedule_meal.dart';
import 'package:pantry/screens/meal_time/meal_time_settings.dart';
import 'package:pantry/screens/meals/create_meal.dart';
import 'package:pantry/screens/meals/edit_meal.dart';
import 'package:pantry/screens/meals/meal_detail.dart';
import 'package:pantry/screens/meals/meal_list_selection.dart';
import 'package:pantry/screens/order_screen.dart';
import 'package:pantry/screens/settings/shopping_trip_settings.dart';
import 'package:pantry/screens/shop_screen.dart';
import 'package:pantry/screens/shopping/shopping_list.dart';
import 'package:pantry/screens/shopping/temp_shopping_list.dart';


class AppRoutes {
  static final routes = [
    GetPage(
      name: Routes.Splash,
      page: () => LoadingScreen(),
    ),
    GetPage(
      name: Routes.SignIn,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: Routes.SignUp,
      page: () => SignUpScreen(),
    ),
    GetPage(
       name: Routes.Landing,
      page: () => LandingPage(),
    ),
    GetPage(
      name: Routes.Home,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: Routes.Shop,
      page: () => ShopScreen(),
    ),
    GetPage(
      name: Routes.Lists,
      page: () => ListsScreen(),
    ),
    GetPage(
      name: Routes.Order,
      page: () => OrderScreen(),
    ),
    GetPage(
      name: Routes.Account,
      page: () => AccountScreen(),
    ),
    GetPage(
      name: Routes.AddIngredient,
      page: () => CreateIngredient(),
    ),
    GetPage(
      name: Routes.CreateMeal,
      page: () => CreateMeal(),
    ),
    GetPage(
      name: Routes.ScheduleMeal,
      page: () => ScheduleMeals(),
    ),
    GetPage(
      name: Routes.MealTimeSettings,
      page: () => MealTimeSettings(),
    ),
    GetPage(
      name: Routes.ShoppingTripSettings,
      page: () => ShoppingTripSettings(),
    ),
    GetPage<EditIngredient>(
      name: Routes.EditIngredient,
      page: () => EditIngredient(ingredientId: Get.arguments,),
    ),
    GetPage(
      name: Routes.IngredientListSelect,
      page: () => IngredientListSelection(onIngredientSelected: Get.arguments,),
    ),
    GetPage(
      name: Routes.EditMeal,
      page: () => EditMeal(meal: Get.arguments),
    ),
    GetPage(
      name: Routes.MealDetail,
      page: () => MealDetail(mealId: Get.arguments),
    ),
    GetPage(
      name: Routes.MealListSelect,
      page: () => MealListSelection(onMealSelected: Get.arguments)
    ),
    GetPage(
      name: Routes.Calendar,
      page: () => Calendar(onDaySelected: Get.arguments),
    ),
    GetPage(
      name: Routes.FinalizeMealSchedule,
      page: () => FinalizeMealSchedule(),
    ),
    GetPage(
      name: Routes.ShoppingList,
      page: () => ShoppingList(tripId: Get.arguments),
    ),
    GetPage(
      name: Routes.TempShoppingList,
      page: () => TempShoppingList(tripId: Get.arguments),
    ),
  ];
}
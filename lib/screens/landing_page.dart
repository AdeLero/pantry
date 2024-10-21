import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pantry/customization/custom_colors.dart';
import 'package:pantry/customization/simplify/pages.dart';
import 'package:pantry/screens/account_screen.dart';
import 'package:pantry/screens/home_screen.dart';
import 'package:pantry/screens/lists_screen.dart';
import 'package:pantry/screens/order_screen.dart';

import 'shop_screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentPageIndex = 2;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: <Widget>[
        ListsScreen(),
        ShopScreen(),
        HomeScreen(),
        OrderScreen(),
        AccountScreen(),
      ][_currentPageIndex],
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        children: [
          SpeedDialChild(
            label: 'Ingredient',
            onTap: () {
              Get.toNamed(Routes.AddIngredient);
            },
          ),
          SpeedDialChild(
              label: 'Meal',
              onTap: () {
                Get.toNamed(Routes.CreateMeal);
              }
          ),
          SpeedDialChild(
              label: 'Meal Schedule',
              onTap: () {
                Get.toNamed(Routes.ScheduleMeal);
              }
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPageIndex,
        unselectedItemColor: AppColors.deepGreen,
        backgroundColor: AppColors.lightGreen,
        selectedItemColor: AppColors.baseWhite,
        onTap: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.list,
              size: 24,
            ),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.cartShopping,
              size: 24,
            ),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.house,
              size: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.burger,
              size: 24,
            ),
            label: 'Order',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 24,
              ),
              label: 'Account'),
        ],
      ),
    );
  }
}
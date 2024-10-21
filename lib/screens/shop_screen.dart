import 'package:flutter/material.dart';
import 'package:pantry/customization/custom_colors.dart';
import 'package:pantry/screens/shopping/saved_shopping_lists.dart';
import 'package:pantry/screens/shopping/shop_online.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: AppColors.deepGreen,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Text(
              'Shopping',
              style: TextStyle(
                color: AppColors.baseWhite,
                fontSize: 40,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                    labelColor: AppColors.deepGreen,
                    labelStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                    overlayColor: WidgetStatePropertyAll(AppColors.deepGreen),
                    unselectedLabelColor: AppColors.otherGray,
                    indicatorColor: AppColors.deepGreen,
                    indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(text: 'List',),
                    Tab(text: 'Online',),
                  ],
                ),
                SizedBox(
                  width: size.width,
                  height: size.height * 0.80,
                  child: TabBarView(
                    children: [
                      SavedShoppingLists(),
                      ShopOnline(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

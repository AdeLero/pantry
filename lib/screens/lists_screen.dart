import 'package:flutter/material.dart';
import 'package:pantry/customization/custom_colors.dart';
import 'package:pantry/screens/ingredients/ingredient_list_editable.dart';
import 'package:pantry/screens/meals/meal_list_editable.dart';

class ListsScreen extends StatelessWidget {
  const ListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  labelColor: AppColors.deepGreen,
                  labelStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                  unselectedLabelColor: AppColors.otherGray,
                  indicatorColor: AppColors.deepGreen,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(text: 'Inventory',),
                    Tab(text: 'Meals',),
                  ],
                ),
                SizedBox(
                  width: size.width,
                  height: size.height * 0.80,
                  child: TabBarView(
                      children: [
                        IngredientListEditable(),
                        MealListEditable(),
                      ],
                  ),
                )
              ],
            ),
          ),
      ),
    );
  }
}


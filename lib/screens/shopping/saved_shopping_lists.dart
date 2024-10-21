import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pantry/customization/custom_colors.dart';
import 'package:pantry/models/shopping_trip_provider.dart';
import 'package:pantry/screens/shopping/generate_shopping_list_bottom_sheet.dart';
import 'package:provider/provider.dart';

class SavedShoppingLists extends StatefulWidget {
  const SavedShoppingLists({super.key});

  @override
  State<SavedShoppingLists> createState() => _SavedShoppingListsState();
}

class _SavedShoppingListsState extends State<SavedShoppingLists> {

  void _showGenerateBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GenerateShoppingListBottomSheet();
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    final shoppingTrips = Provider.of<ShoppingLists>(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () {
              _showGenerateBottomSheet();
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(AppColors.lightGreen),
              foregroundColor: WidgetStatePropertyAll(AppColors.deepGreen),
              fixedSize: WidgetStatePropertyAll(
                Size(320, 40),
              ),
            ),
            child: Text(
              'Generate Shopping List',
            ),
          ),
        ),
        Container(
          width: double.infinity,
          color: AppColors.deepGreen,
          alignment: Alignment.center,
          child: Text(
            'Saved Shopping Lists',
            style: TextStyle(
              color: AppColors.baseWhite,
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
        ),
        shoppingTrips.tempShoppingTrips.isNotEmpty
            ? ListView.builder(
          shrinkWrap: true,
          itemCount: shoppingTrips.tempShoppingTrips.length,
          itemBuilder: (BuildContext context, int index) {
            final trip = shoppingTrips.tempShoppingTrips[index];
            return Container(
              width: 320,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('dd/MM/yy').format(trip.date),
                  ),
                  Text('Purchased')
                ],
              ),
            );
          },
        )
            : Container(),
      ],
    );
  }
}

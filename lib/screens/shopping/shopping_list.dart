import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pantry/customization/custom_colors.dart';
import 'package:pantry/models/shopping_trip_model.dart';
import 'package:pantry/models/shopping_trip_provider.dart';
import 'package:provider/provider.dart';

class ShoppingList extends StatelessWidget {
  final String tripId;
   ShoppingList({required this.tripId});

  @override
  Widget build(BuildContext context) {
    final shoppingTrips =  Provider.of<ShoppingLists>(context, listen: false);
    final trips = shoppingTrips.getTripbyId(tripId);
    final DateTime date =  trips.date;
    final _dateText = DateFormat('dd/MM/yy').format(date);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _dateText,
          style: TextStyle(
            color: AppColors.deepGreen,
          ),
        ),
        actions: [
         IconButton(
           onPressed: () {},
           icon: Icon(
             Icons.share,
           ),
         ),
          IconButton(
            onPressed: () {
            },
            icon: Icon(
              Icons.save,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 40,
            color: AppColors.deepGreen,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            itemCount: trips.shoppingIngredients.length,
            itemBuilder: (BuildContext context, int index) {
              final ingredient = trips.shoppingIngredients[index];
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ingredient.ingredient.ingredientName,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${ingredient.quantity} ${ingredient.ingredient.unitOfMeasurement}',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              );          },
          ),
        ],
      ),
    );
  }
}

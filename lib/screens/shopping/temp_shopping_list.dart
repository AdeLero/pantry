import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pantry/customization/custom_colors.dart';
import 'package:pantry/models/shopping_trip_provider.dart';
import 'package:provider/provider.dart';

class TempShoppingList extends StatelessWidget {
  final String tripId;
  const TempShoppingList({required this.tripId});

  @override
  Widget build(BuildContext context) {
    final shoppingTrips =  Provider.of<ShoppingLists>(context, listen: false);
    final trips = shoppingTrips.tempShoppingTrips;
    final trip = trips.firstWhere((trip) => trip.id == tripId, orElse: () => throw Exception('Shopping trip not found'),);
    final DateTime date =  trip.date;
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
        leading: IconButton(
          onPressed: () {
            shoppingTrips.discardTempShoppingList(
              trips.indexOf(trip),
            );
            Get.back();
          },
          icon: FaIcon(
            FontAwesomeIcons.arrowLeft,
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
              shoppingTrips.saveShoppingList(
                trips.indexOf(trip),
              );
              Get.back();
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
            itemCount: trip.shoppingIngredients.length,
            itemBuilder: (BuildContext context, int index) {
              final ingredient = trip.shoppingIngredients[index];
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

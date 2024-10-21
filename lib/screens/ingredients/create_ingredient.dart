import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pantry/customization/custom_colors.dart';
import 'package:pantry/models/ingredients_model.dart';
import 'package:pantry/models/inventory_model.dart';
import 'package:provider/provider.dart';

class CreateIngredient extends StatelessWidget {
  CreateIngredient({super.key});

  final TextEditingController _ingredientNameC = TextEditingController();
  final TextEditingController _ingredientQtyC = TextEditingController();
  final TextEditingController _criticalQtyC = TextEditingController();
  final TextEditingController _ingredientUOM = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final inventory = Provider.of<Inventory>(context);


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: FaIcon(
            FontAwesomeIcons.arrowLeft,
          ),
          iconSize: 24,
          color: AppColors.deepGreen,
        ),
        elevation: 3,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 90,
                width: 230,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create An',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Ingredient',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 48,
              ),
              TextField(
                controller: _ingredientNameC,
                decoration: InputDecoration(
                  label: Text('Ingredient Name'),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _ingredientNameC.clear();
                    },
                    icon: Icon(
                      Icons.cancel_outlined,
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.deepGreen,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 120,
                    child: TextField(
                      controller: _ingredientQtyC,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Quantity',
                          suffixIcon: IconButton(
                            onPressed: () {
                              _ingredientQtyC.clear();
                            },
                            icon: Icon(
                              Icons.cancel_outlined,
                            ),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.deepGreen,
                              ))),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  SizedBox(
                    width: 120,
                    child: TextField(
                      controller: _criticalQtyC,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Critical Qty',
                          suffixIcon: IconButton(
                            onPressed: () {
                              _criticalQtyC.clear();
                            },
                            icon: Icon(
                              Icons.cancel_outlined,
                            ),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.deepGreen,
                              ))),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: _ingredientUOM,
                decoration: InputDecoration(
                  labelText: 'Unit of Measurement',
                  suffixIcon: IconButton(
                    onPressed: () {
                      _ingredientUOM.clear();
                    },
                    icon: Icon(
                      Icons.cancel_outlined,
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.deepGreen,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () {

                  if (_ingredientNameC.text.isEmpty ||
                      _ingredientQtyC.text.isEmpty ||
                      _ingredientUOM.text.isEmpty) {
                    Get.snackbar(
                      "Invalid Input",
                      "Please fill in all the required fields.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }

                  final double quantity = double.parse(_ingredientQtyC.text);
                  final double? criticalQty = _criticalQtyC.text.isNotEmpty
                      ? double.tryParse(_criticalQtyC.text)
                      : null;

                  inventory.addIngredient(
                    Ingredient(
                        ingredientName: _ingredientNameC.text,
                        quantity: quantity,
                        criticalQuantity: criticalQty,
                        unitOfMeasurement: _ingredientUOM.text),
                  );

                  _ingredientUOM.clear();
                  _ingredientNameC.clear();
                  _criticalQtyC.clear();
                  _ingredientQtyC.clear();
                  Get.back();
                },
                child: Text(
                  'Create Ingredient',
                  style: TextStyle(
                    color: AppColors.baseWhite,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.deepGreen),
                  fixedSize: WidgetStatePropertyAll(
                    Size(320, 40),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
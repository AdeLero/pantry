import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pantry/customization/custom_colors.dart';
import 'package:pantry/models/shopping_settings_model.dart';
import 'package:provider/provider.dart';

class ShoppingTripSettings extends StatefulWidget {
  const ShoppingTripSettings({super.key});

  @override
  State<ShoppingTripSettings> createState() => _ShoppingTripSettingsState();
}

class _ShoppingTripSettingsState extends State<ShoppingTripSettings> {
  final List<String> shoppingFrequency = [
    'Weekly',
    'Fortnightly',
    'Monthly',
  ];
  String? selectedFrequency;
  @override
  Widget build(BuildContext context) {
    final settings =
        Provider.of<ShoppingTripSettingsModel>(context, listen: false);
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
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 210,
              child: Text(
                'How often would you like to restock your',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 32,
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: Image.asset(
                    'lib/customization/assets/images/Pantry_App_Logo_3.png',
                  ),
                ),
                Text(
                  '?',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 32,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            DropdownButton<String>(
              value: selectedFrequency,
              hint: Text('Select Shopping Trips Frequency'),
              items: shoppingFrequency.map((String frequency) {
                return DropdownMenuItem<String>(
                  value: frequency,
                  child: Text(frequency),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedFrequency = newValue;
                  });
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedFrequency != null) {
                  settings.setFrequency(selectedFrequency!);
                  Get.back();
                }
              },
              child: Text(
                'Set Shopping Trips',
              ),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.deepGreen),
                foregroundColor: WidgetStatePropertyAll(AppColors.baseWhite),
                fixedSize: WidgetStatePropertyAll(
                  Size(320, 40),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

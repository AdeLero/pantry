import 'package:flutter/material.dart';

class ShoppingTripSettingsModel extends ChangeNotifier{
  List<String> _frequency = [
    'Weekly',
    'Fortnightly',
    'Monthly',
  ];

  String selectedFrequency = 'Weekly';
  List<String> get frequency => _frequency;

  void setFrequency(String newFrequency) {
    selectedFrequency = newFrequency;
    notifyListeners();
  }
}
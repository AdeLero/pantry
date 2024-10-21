import 'package:get/get.dart';

class DateController extends GetxController {
  var selectedDate = DateTime.now().obs;

  List<DateTime> get fiveDayrange {
    return List.generate(5, (index) {
      return DateTime.now().subtract(Duration(days: 2 - index));
    });
  }

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
  }
}
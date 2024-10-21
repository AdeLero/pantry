import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry/customization/simplify/pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    loadData();
  }
  void loadData() async {
    await Future.delayed(Duration(seconds: 3));
    Get.offNamed(Routes.SignIn);
  }
}
class LoadingScreen extends StatelessWidget {
  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        'lib/customization/assets/images/Pantry_App_loading_screen.png',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      )
    );
  }
}

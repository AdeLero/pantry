import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pantry/customization/custom_colors.dart';
import 'package:pantry/customization/simplify/pages.dart';

import '../other_widgets/profile_picture.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    ProfilePicture(),
                    Text(
                      'Username',
                      style: TextStyle(
                        color: AppColors.deepGreen,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.MealTimeSettings);
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.lightGray,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.clock,
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                                'Meal Time Settings'
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.ShoppingTripSettings);
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.lightGray,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.bagShopping,
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                                'Shopping Trip Settings'
                            )
                          ],
                        ),
                      ),
                    ),
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
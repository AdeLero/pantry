import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pantry/customization/custom_colors.dart';
import 'package:pantry/customization/simplify/pages.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 50,left: 20, right: 20),
            child: Column(
              children: [
                Image.asset(
                  'lib/customization/assets/images/Pantry_App_Logo_3.png',
                  height: 110,
                ),
                Container(
                  padding: EdgeInsets.all(24),
                  margin: EdgeInsets.only(top: 50, bottom: 8),
                  height: 360,
                  width: 320,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.lightGray,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(bottom: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'mail@mail.com',
                                hintStyle: TextStyle(
                                  color: AppColors.otherGray,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.otherGray,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(bottom: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'P*****d',
                                hintStyle: TextStyle(
                                  color: AppColors.otherGray,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.otherGray,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.Landing);
                        },
                        child: Text('Sign in'),
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.black),
                          foregroundColor: WidgetStatePropertyAll(Colors.white),
                          fixedSize: WidgetStatePropertyAll(Size(272,40),),
                        ),
                      ),
                      SizedBox(height: 5),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot password?'
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'OR',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                    width: 320,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.otherGray,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.google,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Sign in with Google',
                          style: TextStyle(
                            color: AppColors.otherGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an Account?",
                      style: TextStyle(
                        color: AppColors.lightGray,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.SignUp);
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: AppColors.lightGray,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ),
    );
  }
}

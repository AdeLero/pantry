import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pantry/customization/custom_colors.dart';
import 'package:pantry/customization/simplify/pages.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Image.asset(
                'lib/customization/assets/images/Pantry_App_Logo_3.png',
                height: 100,
              ),
              Container(
                margin: EdgeInsets.only(top: 24, bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Username',
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Username',
                        hintStyle: TextStyle(
                          color: AppColors.lightGray,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.lightGray),
                        )
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'mail@mail.com',
                          hintStyle: TextStyle(
                            color: AppColors.lightGray,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.lightGray),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'P******d',
                          hintStyle: TextStyle(
                            color: AppColors.lightGray,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.lightGray),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Re-enter Password',
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'P******d',
                          hintStyle: TextStyle(
                            color: AppColors.lightGray,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.lightGray),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.deepGreen),
                  foregroundColor: WidgetStatePropertyAll(AppColors.baseWhite),
                  fixedSize: WidgetStatePropertyAll(Size (272,40),),
                ),
                child: Text('Sign Up'),
              ),
              SizedBox(height: 5),
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
                      Get.toNamed(Routes.SignIn);
                    },
                    child: Text(
                      'Sign In',
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

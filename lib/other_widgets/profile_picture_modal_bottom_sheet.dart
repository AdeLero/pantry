import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pantry/customization/custom_colors.dart';

class ProfilePictureModalBottomSheet extends StatefulWidget {
  const ProfilePictureModalBottomSheet({super.key});

  @override
  State<ProfilePictureModalBottomSheet> createState() => _ProfilePictureModalBottomSheetState();
}

class _ProfilePictureModalBottomSheetState extends State<ProfilePictureModalBottomSheet> {
  File? _profilePicture;

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    try {
      final pickedFile =
      await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile !=null) {
        setState(() {
          _profilePicture = File(pickedFile.path);
        });
      }
    } catch (e) {
      Get.snackbar('Error picking Image', '$e');
    }
  }

  Future<void> _getImageFromCamera() async {
    final picker = ImagePicker();
    try {
      final pickedFile =
      await picker.pickImage(source: ImageSource.camera);
      if (pickedFile !=null) {
        setState(() {
          _profilePicture = File(pickedFile.path);
        });
      }
    } catch (e) {
      Get.snackbar('Error picking Image', '$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.faintGrey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Edit Profile Picture',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: Get.back,
                icon: FaIcon(
                  FontAwesomeIcons.close,
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.baseWhite,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(children: [
              GestureDetector(
                onTap: _getImageFromGallery,
                child: Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColors.baseWhite,
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.lightGray,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Choose Photo'),
                      FaIcon(
                        FontAwesomeIcons.photoFilm,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: _getImageFromCamera,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.baseWhite,
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.lightGray,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Take Photo'),
                      FaIcon(
                        FontAwesomeIcons.camera,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

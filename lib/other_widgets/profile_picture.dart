import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pantry/customization/custom_colors.dart';
import 'package:pantry/other_widgets/profile_picture_modal_bottom_sheet.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  bool _isEditButtonVisible = false;

  void _toggleEditButtonVisibility() {
    setState(() {
      _isEditButtonVisible = !_isEditButtonVisible;
    });
  }

  void _showProfilePictureBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return ProfilePictureModalBottomSheet();
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleEditButtonVisibility,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('lib/customization/assets/images/Profile_Picture.png'),
            backgroundColor: AppColors.lightGreen,
          ),
          if (_isEditButtonVisible)
            GestureDetector(
              onTap: _showProfilePictureBottomSheet,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.lightGray,
                  borderRadius: BorderRadius.circular(50),
                ),
                height: 100,
                width: 100,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.camera,
                    size: 36,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

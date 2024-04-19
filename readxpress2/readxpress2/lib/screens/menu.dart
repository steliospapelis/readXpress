import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readxpress2/screens/home.dart';
import 'package:readxpress2/screens/library.dart';
import 'package:readxpress2/screens/settings.dart';
import 'package:readxpress2/themes/app_styles.dart';
import 'package:readxpress2/themes/theme_config.dart';
import 'package:readxpress2/themes/image_paths.dart';
import 'package:readxpress2/widgets/custom_button.dart';
import 'package:readxpress2/widgets/image_view.dart';
import 'package:readxpress2/widgets/custom_appbar.dart';
import 'package:readxpress2/themes/sizes.dart';
import 'package:readxpress2/screens/progress.dart';
import 'package:readxpress2/screens/goals.dart';
  

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, 
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 250.h, 
              padding: EdgeInsets.all(7.h),
              decoration: AppDecoration.outlineBlack,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 50.v),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 43.v,
                      width: 45.h,
                      margin: EdgeInsets.only(right: 37.h),
                      decoration: BoxDecoration(
                        color: appTheme.blue300.withOpacity(0.66),
                        borderRadius: BorderRadius.circular(22.h),
                      ),
                    ),
                  ),
                  SizedBox(height: 7.v),
                  _buildHomeButton(context),
                  SizedBox(height: 23.v),
                  _buildLibraryButton(context),
                  SizedBox(height: 23.v),
                  _buildGoalsButton(context),
                  SizedBox(height: 23.v),
                  SizedBox(
                    height: 47.v,
                    width: 119.h,
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        _buildProgressButton(context),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            height: 22.adaptSize,
                            width: 22.adaptSize,
                            decoration: BoxDecoration(
                              color: appTheme.blue300.withOpacity(0.66),
                              borderRadius: BorderRadius.circular(11.h),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.v),
                  _buildSettingsButton(context),
                  SizedBox(height: 25.v),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 109.adaptSize,
              width: 109.adaptSize,
              decoration: BoxDecoration(
                color: appTheme.blue300.withOpacity(0.66),
                borderRadius: BorderRadius.circular(54.h),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: 70.v,
                right: 100.h,
              ),
              child: Text(
                "Menu",
                style: theme.textTheme.titleLarge,
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.img2RemovebgPreview,
            height: 64.v,
            width: 104.h,
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(
              left: 2.h,
              top: 27.v,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeButton(BuildContext context) {
    return CustomElevatedButton(
      width: 113.h,
      text: "Home",
      leftIcon: Container(
        margin: EdgeInsets.only(right: 8.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgHouse,
          height: 18.adaptSize,
          width: 18.adaptSize,
        ),
      ),
      onPressed: () {
        HapticFeedback.vibrate();
        Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePageScreen()), 
       );
      },
    );
  }

  Widget _buildLibraryButton(BuildContext context) {
    return CustomElevatedButton(
      width: 113.h,
      text: "Library",
      leftIcon: Container(
        margin: EdgeInsets.only(right: 8.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgLibrarybooks,
          height: 18.adaptSize,
          width: 18.adaptSize,
        ),
      ),
      onPressed: () {
        HapticFeedback.vibrate();
        Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LibraryScreen()), 
       );
      },
    );
  }

  Widget _buildGoalsButton(BuildContext context) {
    return CustomElevatedButton(
      width: 113.h,
      text: "Goals",
      leftIcon: Container(
        margin: EdgeInsets.only(right: 8.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgOutlinedflag,
          height: 18.adaptSize,
          width: 18.adaptSize,
        ),
      ),
      onPressed: () {
        HapticFeedback.vibrate();
        Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GoalsScreen()), 
        );
      },
    );
  }

  Widget _buildProgressButton(BuildContext context) {
    return CustomElevatedButton(
      width: 113.h,
      text: "Progress",
      leftIcon: Container(
        margin: EdgeInsets.only(right: 8.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgCheckmark,
          height: 18.adaptSize,
          width: 18.adaptSize,
        ),
      ),
      alignment: Alignment.topRight,
      onPressed: () {
        HapticFeedback.vibrate();
        Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProgressScreen()), 
        );
      },
    );
  }

  Widget _buildSettingsButton(BuildContext context) {
    return CustomElevatedButton(
      width: 113.h,
      text: "Settings",
      leftIcon: Container(
        margin: EdgeInsets.only(right: 8.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgSearch,
          height: 18.adaptSize,
          width: 18.adaptSize,
        ),
      ),
      onPressed: () {
        HapticFeedback.vibrate();
        Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingsPage()), 
        );
      },
    );
  }
}

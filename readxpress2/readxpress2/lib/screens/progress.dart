import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readxpress2/app_export.dart';
import 'package:readxpress2/screens/home.dart';
import 'package:readxpress2/screens/menu.dart';
import 'package:readxpress2/widgets/custom_appbar.dart';

// ignore_for_file: must_be_immutable
class ProgressScreen extends StatelessWidget {
  OverlayEntry? _overlayEntry;
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Container(
            
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildAppBar(context),
                SizedBox(height: 41.v),
                _buildSixtyOne(),
                SizedBox(height: 78.v),
                _buildFiftyEight(),
                SizedBox(height: 78.v),
              ],
            ),
          ),
        ),
      ),
    );
  }

    PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: Column(
        children: [
          Row(
            children: [
              AppbarLeadingImage(
                imagePath: ImageConstant.imgMegaphone,
                margin: EdgeInsets.only(
                  top: 9.v,
                  bottom: 11.v,
                ),
                onTap: () {
          onTapMenuButton(context);
        },
              ),
              Container(
                width: 174.h,
                margin: EdgeInsets.only(
                  left: 32.h,
                  top: 8.v,
                  bottom: 2.v,
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Read",
                        style: ThemeHelper().themeData().textTheme.headlineMedium,
                      ),
                      TextSpan(
                        text: "X",
                        style: CustomTextStyles.headlineMediumAmberA700,
                      ),
                      TextSpan(
                        text: "press",
                        style: ThemeHelper().themeData().textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              AppbarLeadingImage(
                imagePath: ImageConstant.img38745835070228,
                margin: EdgeInsets.only(left: 29.h),
                 onTap: () {
                HapticFeedback.vibrate();
          Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePageScreen()),
      );
        },
              ),
            ],
          ),
          SizedBox(
            width: double.maxFinite,
            child: Divider(),
          ),
        ],
      ),
      styleType: Style.bgFill,
    );
  }

  void onTapMenuButton(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child: GestureDetector(
          onTap: () {
            // Dismiss the overlay when tapped outside the menu
            _overlayEntry?.remove();
          },
          child: Container(
            color: Colors.black.withOpacity(0.1),
            child: Center(
              child: Container(
                width: 800.h,
                height: 800.v,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.transparent,
                ),
                child: Align(
        alignment: Alignment.topLeft,
        child: MenuScreen(),
      ),
              ),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context)?.insert(_overlayEntry!);
  }
  }

  Widget _buildSixtyOne() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 48.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 1.h,
              right: 23.h,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgSettingsAmberA700,
                  height: 35.adaptSize,
                  width: 35.adaptSize,
                  margin: EdgeInsets.only(
                    top: 4.v,
                    bottom: 20.v,
                  ),
                ),
                Container(
                  height: 59.v,
                  width: 176.h,
                  margin: EdgeInsets.only(left: 5.h),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 200.h,
                          margin: EdgeInsets.only(left: 0.h),
                          child: Text(
                            "Progress",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineMedium!.copyWith(
                              height: 1.29,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 176.h,
                          child: Text(
                            "Track your progress!",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.bodySmallAmberA700.copyWith(
                              height: 1.33,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 65.v),
          Padding(
            padding: EdgeInsets.only(right: 75.h),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 65.v,
                    bottom: 69.v,
                  ),
                  child: Text(
                    "Progress",
                    style: CustomTextStyles.bodySmallAmberA700,
                  ),
                ),
                Container(
                  height: 200.v,
                  width: 76.h,
                  margin: EdgeInsets.only(left: 5.h),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: 200.v,
                          child: VerticalDivider(
                            width: 1.h,
                            thickness: 1.v,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 2.v),
                          child: SizedBox(
                            child: Divider(
                              color: appTheme.amberA700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 100.v,
                    bottom: 71.v,
                  ),
                  child: SizedBox(
                    child: Divider(
                      color: appTheme.amberA700,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 52.v,
                    bottom: 71.v,
                  ),
                  child: SizedBox(
                    child: Divider(
                      color: appTheme.amberA700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Divider(
              color: appTheme.blue300,
              indent: 55.h,
              endIndent: 28.h,
            ),
          ),
          SizedBox(height: 7.v),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Date",
              style: CustomTextStyles.bodySmallAmberA700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiftyEight() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 7.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 85.h,
                  margin: EdgeInsets.only(bottom: 2.v),
                  child: Text(
                    "Books Read this year",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.bodySmallBlue300.copyWith(
                      height: 1.33,
                    ),
                  ),
                ),
                Container(
                  width: 85.h,
                  margin: EdgeInsets.only(left: 25.h),
                  child: Text(
                    "Time Spent Reading",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.bodySmallBlue300.copyWith(
                      height: 1.33,
                    ),
                  ),
                ),
                Container(
                  width: 85.h,
                  margin: EdgeInsets.only(
                    left: 20.h,
                    bottom: 2.v,
                  ),
                  child: Text(
                    "Goals Achieved",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.bodySmallBlue300.copyWith(
                      height: 1.33,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 29.v),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(
                left: 24.h,
                right: 8.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 10.adaptSize,
                        width: 10.adaptSize,
                        decoration: BoxDecoration(
                          color: appTheme.blue300,
                          borderRadius: BorderRadius.circular(
                            5.h,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.v),
                      Container(
                        width: 45.adaptSize,
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.h,
                          vertical: 11.v,
                        ),
                        decoration: AppDecoration.fillBlue.copyWith(
                          borderRadius: BorderRadiusStyle.circleBorder20,
                        ),
                        child: Text(
                          "2",
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 10.adaptSize,
                        width: 10.adaptSize,
                        decoration: BoxDecoration(
                          color: appTheme.blue300,
                          borderRadius: BorderRadius.circular(
                            5.h,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.v),
                      Container(
                        width: 45.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.h,
                          vertical: 11.v,
                        ),
                        decoration: AppDecoration.fillBlue.copyWith(
                          borderRadius: BorderRadiusStyle.circleBorder20,
                        ),
                        child: Text(
                          "30h",
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          right: 20.h),
                        height: 10.adaptSize,
                        width: 10.adaptSize,
                        decoration: BoxDecoration(
                          color: appTheme.blue300,
                          borderRadius: BorderRadius.circular(
                            5.h,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.v),
                      Container(
                         margin: EdgeInsets.only(
                          right: 20.h),
                        width: 44.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.h,
                          vertical: 10.v,
                        ),
                        decoration: AppDecoration.fillBlue.copyWith(
                          borderRadius: BorderRadiusStyle.circleBorder20,
                        ),
                        child: Text(
                          "9%",
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


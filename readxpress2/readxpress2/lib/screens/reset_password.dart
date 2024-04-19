

import 'package:flutter/services.dart';
import 'package:readxpress2/app_export.dart';
import 'package:readxpress2/screens/home.dart';
import 'package:readxpress2/screens/sign.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);
  
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  //text controllers
  final _emailcontroller=TextEditingController();
  
  @override
Future<void> resetPassword(BuildContext context) async {
    final email = _emailcontroller.text.trim();
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: SizedBox(
            width: double.maxFinite,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 31.v),
              decoration: AppDecoration.background,
              child: Column(
                children: [
                  _buildAppBar(context),
                  SizedBox(height: 22.v),
                  _buildTitle(),
                  SizedBox(height: 60.v),
                  _buildEmailField(),
                  SizedBox(height: 29.v),
                  _buildContinue(context),
                  SizedBox(height: 36.v),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 18.v,
      leadingWidth: 359.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgVector9,
        margin: EdgeInsets.fromLTRB(50.h, 4.v, 305.h, 4.v),
        onTap: () {
          onTapVectorNine(context);
        },
      ),
    );
  }

  Widget _buildTitle() {
    return SizedBox(
      height: 80.v,
      width: 266.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Reset Password",
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineMedium,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: 
            Text(
              "Forgot your password? Send reset password link!",
              textAlign: TextAlign.left,
              style: CustomTextStyles.bodySmallAmberA700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return CustomFloatingTextField(
      controller: _emailcontroller,
      width: 250.h,
      labelText: "Email",
      labelStyle: CustomTextStyles.bodyMedium_1,
      hintText: "email@gmail.com",
      textInputType: TextInputType.emailAddress,
      prefix: Container(
        margin: EdgeInsets.only(left: 12.h, right: 16.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgIconsMailoutline,
          height: 24.adaptSize,
          width: 24.adaptSize,
        ),
      ),
      prefixConstraints: BoxConstraints(maxHeight: 66.v),
      suffix: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgCheckmark,
          height: 24.adaptSize,
          width: 24.adaptSize,
        ),
      ),
      suffixConstraints: BoxConstraints(maxHeight: 66.v),
    );
  }

  

  

  Widget _buildContinue(BuildContext context) {
  return CustomElevatedButton(
    width: 200.h,
    text: "Send Reset Password Email",
    onPressed: () async {
      HapticFeedback.vibrate();
      try {
        // Attempt to sign in
        await resetPassword(context);
      } catch (e) {
        // Handle authentication failure
        print('Failed to send reset password email: $e');
      }
    },
  );
}

  Widget _buildDivider() {
    return SizedBox(
      height: 38.v,
      width: 255.h,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 16.v),
              child: SizedBox(
                width: 255.h,
                child: Divider(
                  color: appTheme.amberA700,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 27.h,
              margin: EdgeInsets.only(left: 113.h),
              padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 3.v),
              decoration: AppDecoration.background,
              child: Text(
                "or",
                style: CustomTextStyles.bodyLargeGray90001,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onTapVectorNine(BuildContext context) {
    HapticFeedback.vibrate();
    Navigator.pop(context);
  }

}
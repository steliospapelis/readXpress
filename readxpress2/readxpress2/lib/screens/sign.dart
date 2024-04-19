import 'package:readxpress2/app_export.dart';
import 'package:readxpress2/screens/home.dart';
import 'package:readxpress2/screens/login.dart';
import 'package:readxpress2/screens/sign_up.dart';
import 'package:flutter/services.dart';


class SignScreen extends StatelessWidget {
  const SignScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 61.v),
            decoration: AppDecoration.background,
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Read",
                        style: theme.textTheme.displayMedium),
                      TextSpan(
                        text: "Xpress", 
                        style: CustomTextStyles.displayMediumAmberA700,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 12.v),
                CustomImageView(
                  imagePath: ImageConstant.img38745835070228,
                  height: 200.adaptSize,
                  width: 200.adaptSize,
                ),
                SizedBox(height: 8.v),
                SizedBox(
                  width: 309.h,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Read", 
                          style: theme.textTheme.titleLarge,
                        ),
                        
                        TextSpan(
                          text: "ing ", 
                          style: CustomTextStyles.titleLargeBlue300_1,
                        ),
                        TextSpan(
                          text: "Rede", 
                          style: theme.textTheme.titleLarge,
                        ),
                        TextSpan(
                          text: "f", 
                          style: theme.textTheme.titleLarge,
                        ),
                        TextSpan(
                          text: "ined ,\n", 
                          style: CustomTextStyles.titleLargeBlue300_1,
                        ),
                        TextSpan(
                          text: "Tail", 
                          style: theme.textTheme.titleLarge,
                        ),
                        TextSpan(
                          text: "o", 
                          style: theme.textTheme.titleLarge,
                        ),
                        TextSpan(
                          text: "red ", 
                          style: CustomTextStyles.titleLargeBlue300_1,
                        ),
                        TextSpan(
                          text: "Fo", 
                          style: theme.textTheme.titleLarge,
                        ),
                        TextSpan(
                          text: "r ",
                          style: CustomTextStyles.titleLargeBlue300_1,
                        ),
                        TextSpan(
                          text: "Eve", 
                          style: theme.textTheme.titleLarge,
                        ),
                        TextSpan(
                          text: "ry ", 
                          style: CustomTextStyles.titleLargeBlue300_1,
                        ),
                        TextSpan(
                          text: "Rea", 
                          style: theme.textTheme.titleLarge,
                        ),
                        TextSpan(
                          text: "der", 
                          style: theme.textTheme.titleLarge,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 38.v),
                
                CustomElevatedButton(
                  width: 99.h,
                  text: "Login", 
                  onPressed: () {
                    // Navigate to the login screen
                    HapticFeedback.vibrate();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()), 
                    );
                  },
                ),
                SizedBox(height: 39.v),

                CustomElevatedButton(
                  width: 99.h,
                  text: "Sign Up", 
                  onPressed: () {
                    HapticFeedback.vibrate();
                    // Navigate to the signup screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()), 
                    );
                  },
                ),
                SizedBox(height: 39.v),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

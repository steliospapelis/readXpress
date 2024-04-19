import 'package:flutter/services.dart';
import 'package:readxpress2/app_export.dart';
import 'package:readxpress2/screens/home.dart';
import 'package:readxpress2/screens/reset_password.dart';
import 'package:readxpress2/screens/sign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:readxpress2/screens/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';


// ignore: must_be_immutable
class SettingsPage extends StatelessWidget {
  OverlayEntry? _overlayEntry;

  // TextEditingControllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Future<Map<String, dynamic>> fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String uid = user.uid;
      
        // Fetch user data from Firestore using the UID
        DocumentSnapshot<Map<String, dynamic>> userData =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

        if (userData.exists) {
          Map<String, dynamic> data = userData.data()!;
         
          nameController.text = data['name'] ?? '';
          emailController.text = data['email'] ?? '';
          phoneController.text = data['phone']?.toString() ?? '';

          return data;
        } else {
          print('User data not found.');
          return {};
        }
      } else {
        print('User is null. Not authenticated.');
        return {};
      }
    } catch (e) {
      // Handle any errors during data fetching
      print('Error fetching user data: $e');
      return {};
    }
  }

  void _signOut(BuildContext context) async {
  try {
    // Sign out from Firebase (for email/password users)
    await FirebaseAuth.instance.signOut();

    // Sign out from Google
    await GoogleSignIn().signOut();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignScreen()),
    );
  } catch (e) {
    print('Error signing out: $e');
  }
}

  void _saveChanges(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      // Update user data in Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'name': nameController.text,
        'email': emailController.text,
        'phone': int.tryParse(phoneController.text) ?? 0,
      });
      print('User data updated successfully.');
    }
  }
 @override
Widget build(BuildContext context) {
  return FutureBuilder<Map<String, dynamic>>(
    future: fetchUserData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Text('No user data found.');
      } else {
         Map<String, dynamic> userData = snapshot.data!;
          nameController.text = userData['name'] ?? '';
          emailController.text = userData['email'] ?? '';
          phoneController.text = userData['phone']?.toString() ?? '';
      }
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildAppBar(context),
                SizedBox(height: 40.v),
                SizedBox(height: 10.v,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 20.adaptSize),
                    
                      CustomImageView(
                        imagePath: ImageConstant.imgIconsSettingsFilled24px,
                        height: 24.h,
                        width: 24.h,
                        onTap: () {},
                      ),
                      SizedBox(width: 8.adaptSize),
                      Text(
                        'Settings',
                        style: CustomTextStyles.titleLargeBlue300_1,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 40.v)),
                      CustomCheckboxButton(
                        value: true,
                        text: 'Enabled Notifications',
                        onChange: (value) {},
                      ),
                      Spacer(),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 40.v)),
                      CustomCheckboxButton(
                        value: true,
                        text: 'Wearable Notifications',
                        onChange: (value) {},
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h,),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 20.v)),
                      CustomImageView(
                        imagePath: ImageConstant.imgLockAmberA700,
                        height: 24.h,
                        width: 24.h,
                        onTap: () {},
                      ),
                      SizedBox(width: 8.adaptSize),
                      Text(
                        'Personal Information',
                        style: CustomTextStyles.bodyLargeBlue300,
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 40.v)),
                      CustomImageView(
                        imagePath: ImageConstant.imgLockAmberA70024x24,
                        height: 24.h,
                        width: 24.h,
                        onTap: () {},
                      ),
                      SizedBox(width: 8.adaptSize),
                      Expanded(
                        child: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 8.adaptSize,),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 40.v)),
                      CustomImageView(
                        imagePath: ImageConstant.imgIconsMailOutlineAmberA700,
                        height: 24.h,
                        width: 24.h,
                        onTap: () {},
                      ),
                      SizedBox(width: 8.adaptSize),
                      Expanded(
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 8.adaptSize,),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 40.v)),
                      CustomImageView(
                        imagePath: ImageConstant.imgMinimizeAmberA700,
                        height: 24.h,
                        width: 24.h,
                        onTap: () {},
                      ),
                      SizedBox(width: 8.adaptSize),
                      Expanded(
                        child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Phone',
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 16.adaptSize),
                  Align(
                    alignment: Alignment.center,
                    child: CustomElevatedButton(
                      width: 160.h,
                      text: "Save Changes",
                      onPressed: () {
                        HapticFeedback.vibrate();
                        _saveChanges(context);
                      },
                      buttonTextStyle: CustomTextStyles.bodyMediumWhiteA700,
                      buttonStyle: ElevatedButton.styleFrom(
                        backgroundColor: appTheme.blue300,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h,),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.vibrate();
                      _signOut(context);
                    },
                    child: Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 20.v)),
                        CustomImageView(
                          imagePath: ImageConstant.imgLogout,
                          height: 24.h,
                          width: 24.h,
                          onTap: () {},
                        ),
                        SizedBox(width: 8.adaptSize),
                        Text(
                          'Sign Out',
                          style: CustomTextStyles.bodyLargeBlue300,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
      },
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

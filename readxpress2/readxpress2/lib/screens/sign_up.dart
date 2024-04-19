import 'package:flutter/services.dart';
import 'package:readxpress2/app_export.dart';
import 'package:readxpress2/screens/login.dart';
import 'package:readxpress2/screens/sign.dart';
import 'package:readxpress2/screens/home.dart';
import 'package:readxpress2/screens/reset_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

    @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  //text controllers
  final _emailcontroller=TextEditingController();
  final _passwordcontroller=TextEditingController();
  final _namecontroller=TextEditingController();
  final _phonecontroller=TextEditingController();

  Future<void> signup(BuildContext context) async {
  try {
    final email = _emailcontroller.text?.trim();
    final password = _passwordcontroller.text?.trim();

    // Validate email and password
    if (email == null || email.isEmpty || password == null || password.isEmpty) {
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text('All fields must be filled correctly.'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    //Password Length Validation
    if (password.length < 6) {
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text('Password must be at least 6 characters.'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    // Attempt to sign up
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    
    User? user = userCredential.user;
    if (user != null) {
      // Navigate to the next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePageScreen()),
      );

      addUserData(
        _namecontroller.text.trim(),
        int.parse(_phonecontroller.text.trim()),
        _emailcontroller.text.trim(),
      );
    } else {
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text('Error: Email already in use or weak password.'),
          duration: Duration(seconds: 3),
        ),
      );
      print('User is null. Authentication failed.');
    }
  } catch (e) {
    // Handle authentication failure
    print('Failed to sign up: $e');
    // You can display an error message to the user if needed
    _scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Text('Email already in use. Sign in instead!'),
        duration: Duration(seconds: 3),
      ),
    );
  }
}



Future<void> addUserData(String name, int phone, String email) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': name,
        'phone': phone,
        'email': email,
        'uid': uid,
      });
    } else {
      print('User is null. Not authenticated.');
    }
  } catch (e) {
    print('Error adding user data: $e');
  }
}


Future<void> signInWithGoogle() async {
  try {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, check if the user already exists
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = userCredential.user;

    if (user != null) {
      // Check if the user already exists in your database
      bool userExists = await checkIfUserExists(user.uid);

      if (!userExists) {
        // If the user doesn't exist, create a new account with the available information
        addUserData("DefaultName", 0, user.email!);
      }

      // Navigate to the home page or any other desired page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePageScreen()),
      );
    }
  } catch (e) {
    print('Failed to sign in with Google: $e');
  }
}

Future<bool> checkIfUserExists(String uid) async {
  try {
    // Use Firebase Firestore to check if the user exists based on their UID
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();

    return userSnapshot.exists;
  } catch (e) {
    print('Error checking user existence: $e');
    return false; // Return false in case of an error
  }
}


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScaffoldMessenger(
        key: _scaffoldKey,
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
                  SizedBox(height: 39.v),
                  _buildName(),
                  SizedBox(height: 22.v),
                  _buildPhone(),
                  SizedBox(height: 22.v),
                  _buildEmailField(),
                  SizedBox(height: 22.v),
                  _buildPasswordField(),
                  SizedBox(height: 31.v),
                  _buildSignUpButton(context),
                  SizedBox(height: 11.v),
                  _buildAlreadyHave(context),
                  SizedBox(height: 15.v),
                  _buildDivider(),
                  SizedBox(height: 10.v),
                  _buildGoogleButton(context),                  
                ], 
              ),
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
      height: 86.v,
      width: 266.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Sign Up",
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineMedium,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              "Please sign up to continue using our app!",
              textAlign: TextAlign.left,
              style: CustomTextStyles.bodySmallAmberA700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildName() {
  return CustomFloatingTextField(
    controller: _namecontroller,
    width: 250.h,
    labelText: "Name",
    labelStyle: CustomTextStyles.bodyMedium_1,
    hintText: "Name",
    prefix: Container(
      margin: EdgeInsets.only(left: 12.h, right: 16.h),
      child: CustomImageView(
        imagePath: ImageConstant.imgLock,
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


  Widget _buildPhone() {
  return CustomFloatingTextField(
    controller: _phonecontroller,
    width: 250.h,
    labelText: "Phone",
    labelStyle: CustomTextStyles.bodyMedium_1,
    hintText: "Phone",
    textInputType: TextInputType.phone,
    prefix: Container(
      margin: EdgeInsets.only(left: 12.h, right: 16.h),
      child: CustomImageView(
        imagePath: ImageConstant.imgMinimize,
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
  
  Widget _buildPasswordField() {
  return CustomFloatingTextField(
    controller: _passwordcontroller,
    width: 250.h,
    labelText: "Password",
    labelStyle: CustomTextStyles.bodyMedium_1,
    hintText: "*****",
    textInputAction: TextInputAction.done,
    textInputType: TextInputType.visiblePassword,
    prefix: Container(
      margin: EdgeInsets.only(left: 12.h, right: 16.h),
      child: CustomImageView(
        imagePath: ImageConstant.imgIconVpnKey,
        height: 24,
        width: 24,
      ),
    ),
    prefixConstraints: BoxConstraints(maxHeight: 66.v),
    isPasswordField: true, 
    suffix: GestureDetector(
      onTap: () {
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgEye,
          height: 24,
          width: 24,
        ),
      ),
    ),
    suffixConstraints: BoxConstraints(maxHeight: 66.v),
  );
}

Widget _buildAlreadyHave(BuildContext context) {
    return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 7.v),
      decoration: AppDecoration.outlineBlack900.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 4.v),
          Text(
            "Already have an account? Sign in here!",
            style: CustomTextStyles.bodySmallAmberA700,
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
  return CustomElevatedButton(
    width: 99.h,
    text: "Sign Up",
    onPressed: () async {
      HapticFeedback.vibrate();
      try {
        print('Sign Up Pressed');
        // Attempt to sign in
        await signup(context);

      } catch (e) {
        
        print('Failed to sign up: $e');
        //Error Message Display
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to sign up. Please check your email and password.',
            ),
            duration: Duration(seconds: 3),
          ),
        );
      }
    },
  );
}

Widget _buildGoogleButton(BuildContext context) {
  return CustomImageView(
    imagePath: ImageConstant.imgGoogle,
    height: 30.0,  // Set the desired height
    width: 30.0,
    onTap: () async {
      HapticFeedback.vibrate();
      try {
        print('Google Sign Up Pressed');
        // Attempt to sign in
        await signInWithGoogle();
      } catch (e) {
        print('Failed to sign up: $e');
        // Error Message Display
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to sign up. Please check your email and password.',
            ),
            duration: Duration(seconds: 3),
          ),
        );
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
              width: 30.h,
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

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:readxpress2/app_export.dart';
import 'package:readxpress2/screens/home.dart';
import 'package:readxpress2/screens/menu.dart';
import 'package:readxpress2/widgets/custom_appbar.dart';

class GoalsScreen extends StatefulWidget {
  @override
  _GoalsScreenState createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  String selectedPeriod = 'Daily'; // Initial selected period
  OverlayEntry? _overlayEntry;

  TextEditingController timeController = TextEditingController();
  TextEditingController pagesController = TextEditingController();
  TextEditingController booksController = TextEditingController();

   Future<Map<String, dynamic>> fetchGoalsData(String period) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;

      // Fetch user data from Firestore using the UID
      DocumentSnapshot<Map<String, dynamic>> userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userData.exists) {
        Map<String, dynamic> data = userData.data()!;
        // Fetch goals data
        Map<String, dynamic> periodGoals =
            data['goals']?[period] ?? {};

        if (periodGoals.isNotEmpty) {

          // Update text controllers
          timeController.text = periodGoals['time']?.toString() ?? '';
          pagesController.text = periodGoals['pages']?.toString() ?? '';
          booksController.text = periodGoals['books']?.toString() ?? '';

          return periodGoals;
        } else {
          // Period goals data not found
          print('$period goals data not found.');
          return {};
        }
      } else {
        // User data not found
        print('User data not found.');
        return {};
      }
    } else {
      // User is null
      print('User is null. Not authenticated.');
      return {};
    }
  } catch (e) {
    // Handle any errors during data fetching
    print('Error fetching $period goals data: $e');
    return {};
  }
}


  void _saveGoalsData(String period) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    String uid = user.uid;

    try {
      int time = int.tryParse(timeController.text) ?? 0;
      int pages = int.tryParse(pagesController.text) ?? 0;
      int books = int.tryParse(booksController.text) ?? 0;

      DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(uid);

      DocumentSnapshot<Map<String, dynamic>> userSnapshot = await userRef.get() as DocumentSnapshot<Map<String, dynamic>>;

      if (!userSnapshot.exists) {
        // User document doesn't exist, create it with goals map and period map
        await userRef.set({
          'goals': {
            period: {
              'time': time,
              'pages': pages,
              'books': books,
            },
          },
        });
      } else {
        // User document exists, update goals data
        await userRef.update({
          'goals.$period.time': time,
          'goals.$period.pages': pages,
          'goals.$period.books': books,
        });
      }

      print('$period goals data saved successfully.');
    } catch (e) {
      print('Error saving $period goals data: $e');
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<Map<String, dynamic>>(
          future: fetchGoalsData(selectedPeriod),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              Map<String, dynamic> goalsData = snapshot.data ?? {};
              print('User data: ${snapshot.data}');
              return SizedBox(
                width: double.maxFinite,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildAppBar(context),
                      SizedBox(height: 41.v),
                      _buildSixtyOne(),
                      SizedBox(height: 50.v),
                      _buildPeriodSelectionRow(),
                      SizedBox(height: 16.v),
                      Divider(
                        color: appTheme.amberA700,
                        thickness: 2,
                        indent: 30.h,
                        endIndent: 30.h,
                      ),
                      SizedBox(height: 36.v),
                      _buildGoalTextField('Time', ImageConstant.imgClock, timeController),
                      SizedBox(height: 36.v),
                      _buildGoalTextField('Pages', ImageConstant.imgPages, pagesController),
                      SizedBox(height: 36.v),
                      _buildGoalTextField('Books', ImageConstant.imgLibrarybooks, booksController),
                      SizedBox(height: 36.v),
                      CustomElevatedButton(
                        width: 99.h,
                        text: "Save",
                        onPressed: () {
                          HapticFeedback.vibrate();
                          _saveGoalsData(selectedPeriod);
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
          },
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

  Widget _buildSixtyOne() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 48.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 1.h,
              right: 25.h,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgOutlinedflag,
                  color: appTheme.amberA700,
                  height: 50.adaptSize,
                  width: 50.adaptSize,
                  margin: EdgeInsets.only(
                    top: 6.v,
                    bottom: 15.v,
                  ),
                ),
                Container(
                  height: 59.v,
                  width: 176.h,
                  margin: EdgeInsets.only(left: 0.h),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 116.h,
                          margin: EdgeInsets.only(left: 26.h),
                          child: Text(
                            "Goals",
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
                            "Keep yourself motivated!",
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
        ],
      ),
    );
  }

  Widget _buildPeriodSelectionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildPeriodButton('Daily'),
        _buildPeriodButton('Monthly'),
        _buildPeriodButton('Yearly'),
      ],
    );
  }

  Widget _buildPeriodButton(String period) {
    return GestureDetector(
      
      onTap: () {
        setState(() {
          selectedPeriod = period;
        
        });
      },
      child: Opacity(
        opacity: selectedPeriod == period ? 1 : 0.5,
        child: Text(
          period,
          style: TextStyle(
            color:  appTheme.blue300
          ),
        ),
      ),
    );
  }

  Widget _buildGoalTextField(String label, String preImg, TextEditingController controller) {
    return CustomFloatingTextField(
      width: 250.h,
      labelText: label,
      labelStyle: CustomTextStyles.bodyMedium_1,
      prefix: Container(
        margin: EdgeInsets.only(left: 12.h, right: 16.h),
        child: CustomImageView(
          imagePath: preImg,
          height: 24.adaptSize,
          width: 24.adaptSize,
        ),
      ),
      prefixConstraints: BoxConstraints(maxHeight: 66.v),
      suffix: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgEdit,
          height: 24.adaptSize,
          width: 24.adaptSize,
        ),
      ),
      suffixConstraints: BoxConstraints(maxHeight: 66.v),
      controller: controller,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readxpress2/screens/menu.dart';
import 'package:readxpress2/screens/reader.dart';
import 'package:readxpress2/themes/app_styles.dart';
import 'package:readxpress2/themes/theme_config.dart';
import 'package:readxpress2/themes/text_styles.dart';
import 'package:readxpress2/themes/image_paths.dart';
import 'package:readxpress2/widgets/BookCard.dart';
import 'package:readxpress2/widgets/custom_appbar.dart';
import 'package:readxpress2/widgets/image_view.dart';
import 'package:readxpress2/themes/sizes.dart';
import 'package:carousel_slider/carousel_slider.dart';



class HomePageScreen extends StatelessWidget {
  OverlayEntry? _overlayEntry;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
      
        body: Center(
        
          child: Container(
            
            padding: EdgeInsets.only(bottom: 20.v),
            child: Container(
              
              width: 320.h,
              
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 33.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgHouseAmberA700,
                              height: 32.adaptSize,
                              width: 32.adaptSize,
                              margin: EdgeInsets.only(
                                top: 6.v,
                                bottom: 14.v,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.h),
                              child: Text(
                                "Home Page",
                                style: theme.textTheme.headlineMedium,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.v),
                        Text(
                          "You're currently reading...",
                          style: CustomTextStyles.titleLargeBlue300,
                        ),
                        SizedBox(height: 10.v),
                        
                        GestureDetector(
                onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ReaderScreen(title : 'Tale of two cities')));
              },
                child :  BookCardWidget(
                title: "Tale of two cities",
                author: "Charles Dickens",
                imagePath: ImageConstant.imgMedia,
                progress: 0.7, 
              ),
                        ),
                        SizedBox(height: 20.v),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgHistory,
                              height: 24.adaptSize,
                              width: 24.adaptSize,
                              margin: EdgeInsets.symmetric(vertical: 7.v),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 12.h),
                              child: Text(
                                "Recent Books :",
                                style: CustomTextStyles.titleLargeBlue300,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.v,),
                        _buildHomePage(),
                        
                      ],
                      
                    ),
                    
                  ),
                 
                 
      
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

 Widget _buildHomePage() {
  List<Map<String, dynamic>> bookcardInfoList = [
    {
      'title': "Jane Eyre",
      'author': "Charlotte Bronte",
      'imagePath': ImageConstant.imgMedia88x68,
    },
    {
      'title': "Wuthering Heights",
      'author': "Emily Bronte",
      'imagePath': ImageConstant.imgMedia1,
    },
    {
      'title': "Rebecca",
      'author': "Daphne du Maurier",
      'imagePath': ImageConstant.imgMedia2,
    },
    {
      'title': "Dune",
      'author': "Frank Herbert",
      'imagePath': ImageConstant.imgMedia3,
    },
    {
      'title': "1984",
      'author': "G. Orwell",
      'imagePath': ImageConstant.imgMedia4,
    },
  ];

  return Align(
    alignment: Alignment.bottomRight,
    child: SizedBox(
      height: 225.v,
      width: 326.h,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          
          
          CarouselSlider.builder(
            options: CarouselOptions(
              height: 300.v,
              initialPage: 0,
              autoPlay: true,
              viewportFraction: 1.0,
              enableInfiniteScroll: false,
              scrollDirection: Axis.horizontal,
              onPageChanged: (
                index,
                reason,
              ) {
              },
            ),
            itemCount: bookcardInfoList.length,
            itemBuilder: (context, index, realIndex) {
              Map<String, dynamic> info = bookcardInfoList[index];
              return GestureDetector(
                onTap: () {
                  
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ReaderScreen(title : info['title'])));
                },
                child: BookCardWidget(
                title: info['title'],
                author: info['author'],
                imagePath: info['imagePath'],
                progress: 0.15*index, 
              ),
              );
            },
          ),
        ],
      ),
    ),
  );
}



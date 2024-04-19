import 'dart:async';

import 'package:flutter/material.dart';
import 'package:light_sensor/light_sensor.dart';
import 'package:readxpress2/app_export.dart';
import 'package:readxpress2/screens/bookrepo.dart';
import 'package:readxpress2/screens/readsettings.dart';
import 'package:screen_brightness/screen_brightness.dart';

class ReaderScreen extends StatefulWidget {
  String title;

  ReaderScreen({required this.title});

  @override
  _ReaderScreenState createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  OverlayEntry? _overlayEntry;
  late String text;
  late RichText chapter;
  late TextStyle originalStyle;
  late bool brightness=false;
  Color scaffoldBackgroundColor = appTheme.whiteA700; 
  late int luxValue;
  double brightnessValue= 1.0;
  late bool roboto = false;
  late StreamSubscription<int> luxSubscription;
  @override
  void initState() {
    super.initState();
    // Initialize the text based on the title
    text = BookRepository.books[widget.title] ??
        'Text not found for the given title.';

    chapter = buildRichText();

    luxValue = 0;
    luxSubscription = LightSensor.luxStream().listen((lux) {});
  }

  @override
  void dispose() {

    luxSubscription?.cancel();
    
    super.dispose();
  }

  RichText buildRichText() {
    return RichText(
      text: TextSpan(
        text: text,
        style: CustomTextStyles.bodyMedium_2.copyWith(height: 1.43)
        ,
      ),
    );
  }

  void updateText(RichText chapterNew, bool isRoboto) {
    setState(() {
      chapter = chapterNew;
      roboto=isRoboto;
    });
  }

  void updateBackgroundColor(Color color) {
  print('Updating background color to: $color');
  setState(() {
    scaffoldBackgroundColor = color;
  });
}

void updateTextAndStyle(RichText text, TextStyle style) {
  setState(() {
    chapter = text;
    originalStyle = style;
  });
}



void updateBrightness(bool autoBrightness) {
  WidgetsBinding.instance?.addPostFrameCallback((_) {
    print('Updating brightness to: $autoBrightness');
    luxSubscription = LightSensor.luxStream().listen((lux) {


      setState(() {
        brightness = autoBrightness;
        luxValue = lux;
        
        brightnessValue = 0.5;
        if(brightness) {
        if(luxValue >1500) {
          brightnessValue=1.0;
        }
         else if(luxValue >1000){
          brightnessValue=0.9;
         } 
         else if(luxValue >800){
          brightnessValue=0.8;
         } 
        else if(luxValue >600){
          brightnessValue=0.7;
         } 
         else if(luxValue >500){
          brightnessValue=0.6;
         } 
         else if(luxValue >400){
          brightnessValue=0.55;
         } 
         else if(luxValue >300){
          brightnessValue=0.5;
         } 
         else if(luxValue >200){
          brightnessValue=0.45;
         } 
          else if(luxValue >20){
          brightnessValue=0.4;
         } 
         else {
          brightnessValue=0.2;
         }
        ScreenBrightness().setScreenBrightness(brightnessValue);
        }
              });
    
    }
    );
    
  });
}


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapReadSettings(context, chapter);
      },
      child: SafeArea(
        child: Scaffold(
          
          body: SizedBox.expand(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 5.h,
                vertical: 33.v,
              ),
              decoration: BoxDecoration(
                color: scaffoldBackgroundColor,
                 ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 3.v),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          width: 335.h,
                          margin: EdgeInsets.only(left: 15.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              SizedBox(height: 20.0),
                              chapter,
                            ],
                          ),
                        ),
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

  void onTapReadSettings(BuildContext context, chapter) {
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
            child: ReadSettingsPageScreen(
                updateTextCallback: updateText, chapter: chapter, updateBackgroundColorCallback: updateBackgroundColor, scaffoldBackgroundColor: scaffoldBackgroundColor, updateTextAndStyleCallback: updateTextAndStyle, updateBrightnessCallback: updateBrightness, passbright: brightness, isRoboto: roboto, onCloseOverlay: () {
              // Remove the overlay when onCloseOverlay is called
              _overlayEntry?.remove();
            },),
          ),
        ),
      ),
    );
    Overlay.of(context)?.insert(_overlayEntry!);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readxpress2/screens/sign.dart';
import 'package:readxpress2/themes/theme_config.dart';
import 'package:readxpress2/themes/sizes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) {
        if (user != null) {
        print(user.uid);
        }
      });
    runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return Sizer(
      builder: (context, deviceType) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      title: 'readxpress',
      home: SignScreen(),
    );
  },
);
}
}
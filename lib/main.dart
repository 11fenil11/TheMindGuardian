import 'package:firebase_login/Screens/Welcome/welcome_screen.dart';
import 'package:firebase_login/constraints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'The Mind Guardian',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.black,
        ),
        home: WelcomeScreen(),
      ),
    );
  }
}
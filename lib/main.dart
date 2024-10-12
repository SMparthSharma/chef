import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mr_chef/activity/constant.dart';
import 'package:mr_chef/activity/home_screen.dart';

import 'activity/searchPage.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        fontFamily: "Hellix"
      ),
     // debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}


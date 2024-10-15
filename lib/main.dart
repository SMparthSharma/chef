import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mr_chef/activity/constant.dart';
import 'package:mr_chef/activity/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';



void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent
  ));
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        fontFamily: "Hellix"
      ),
     // debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}


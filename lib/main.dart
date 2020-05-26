
import 'package:appcarburant/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor:Color(0xFF5451A1) ,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}


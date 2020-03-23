import 'package:flutter/material.dart';
import 'pages/main_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      theme: ThemeData(primarySwatch: Colors.blue),
      //home: MainPage(),
      routes: {
        "/": (context) => MainPage(),
        "/home": (context) => MainPage(),
      },
    );
  }
}

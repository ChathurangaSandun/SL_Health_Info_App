import 'package:flutter/material.dart';
import 'pages/main_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'pages/home_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'SL Health Info',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Home(),
    );
  }
}

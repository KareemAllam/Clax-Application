import 'package:flutter/material.dart';
import 'package:fcm_test/Homepage.dart';
import 'package:fcm_test/SecondPage.dart';
import 'package:fcm_test/ThirdPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      routes: {
        "/": (context) => MyHomePage(title: 'Flutter Demo Home Page'),
        "/second": (context) => SecondPage(),
        "/third": (context) => ThirdPage(),
        "/forth": (context) => ForthPage(),
        "/fifth": (context) => FifthPage(),
      },
      initialRoute: '/',
    );
  }
}

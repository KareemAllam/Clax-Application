import 'package:flutter/material.dart';
import 'package:googlemap/PolyLines.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: TestMapPolyline(),
    );
  }
}

// AIzaSyBkN4KS6PmgIVOwS4p_ceT5SlYqyQ4AsmA

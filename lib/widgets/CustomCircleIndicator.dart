// Dart & Other Packages
import 'dart:async';
// Flutter Material Components
import 'package:flutter/material.dart';

class CustomCircleIndicator extends StatefulWidget {
  final int seconds;
  CustomCircleIndicator(this.seconds);
  @override
  _CustomCircleIndicatorState createState() => _CustomCircleIndicatorState();
}

class _CustomCircleIndicatorState extends State<CustomCircleIndicator> {
  Timer timer;
  double value = 0;
  @override
  void initState() {
    super.initState();
    double _value = (1 / (widget.seconds * 10));
    timer = Timer.periodic(Duration(milliseconds: 100), (_timer) {
      setState(() {
        value += _value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: value,
      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
      backgroundColor: Colors.grey,
    );
  }
}

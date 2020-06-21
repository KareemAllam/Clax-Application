import 'package:flutter/material.dart';

class NullContent extends StatelessWidget {
  final String things;
  final double vPadding;
  NullContent({this.things = "محتوى", this.vPadding = 20});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: vPadding),
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 0.5, color: Colors.grey)],
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      child: Text('لا يوجد اي $things'),
    );
  }
}

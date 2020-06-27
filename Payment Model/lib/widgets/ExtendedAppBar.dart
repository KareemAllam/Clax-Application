import 'package:flutter/material.dart';

class ExtendedAppbar extends StatelessWidget {
  final Widget child;
  ExtendedAppbar({this.child});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height * 0.35,
      child: child,
    );
  }
}

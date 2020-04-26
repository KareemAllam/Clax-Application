import 'package:flutter/material.dart';

class ExtendedAppbar extends StatelessWidget {
  final Widget child;
  ExtendedAppbar({this.child});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: height * 0.35,
      child: child,
    );
  }
}

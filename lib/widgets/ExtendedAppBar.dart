import 'package:flutter/material.dart';

class ExtendedAppbar extends StatelessWidget {
  final Widget child;
  ExtendedAppbar({this.child});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.2,
      width: double.infinity,
      alignment: Alignment.center,
      child: child,
    );
  }
}

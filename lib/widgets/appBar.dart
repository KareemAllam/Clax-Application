import 'package:flutter/material.dart';

Widget buildAppBar(
  BuildContext context,
  String appTitle,
) {
  return AppBar(
    title: Text(
      appTitle,
      style:
          Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
    ),
  );
}

import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Color(0xffe3e8ee),
  dividerColor: Colors.black12,
  // primaryColor: Colors.deepPurple,
  primaryColor: Colors.black,
  primaryColorLight: Colors.deepPurple[300],
  accentColor: Colors.amber,
  backgroundColor: Colors.white,
  secondaryHeaderColor: Colors.grey,
  canvasColor: Colors.white,
  fontFamily: 'Cairo',
  snackBarTheme: SnackBarThemeData(),
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 102,
      letterSpacing: -1.5,
      fontWeight: FontWeight.w200,
    ),
    headline2: TextStyle(
        fontSize: 64, letterSpacing: -0.5, fontWeight: FontWeight.w200),
    headline3:
        TextStyle(fontSize: 51, letterSpacing: 0, fontWeight: FontWeight.w400),
    headline4: TextStyle(
        fontSize: 36, letterSpacing: 0.25, fontWeight: FontWeight.w400),
    headline5:
        TextStyle(fontSize: 25, letterSpacing: 0, fontWeight: FontWeight.w400),
    headline6: TextStyle(
        fontSize: 21, letterSpacing: 0.15, fontWeight: FontWeight.w600),
    subtitle1: TextStyle(
        fontSize: 17, letterSpacing: 0.15, fontWeight: FontWeight.w400),
    subtitle2: TextStyle(
        fontSize: 15, letterSpacing: 0.1, fontWeight: FontWeight.w600),
    bodyText1: TextStyle(
        fontSize: 17, letterSpacing: 0.5, fontWeight: FontWeight.w400),
    bodyText2: TextStyle(
        fontSize: 15, letterSpacing: 0.25, fontWeight: FontWeight.w400),
    button: TextStyle(
        fontSize: 15,
        letterSpacing: 1.25,
        fontWeight: FontWeight.w600,
        fontFamily: "Cairo"),
    caption: TextStyle(
        fontSize: 13, letterSpacing: 0.4, fontWeight: FontWeight.w400),
    overline: TextStyle(
        fontSize: 11, letterSpacing: 1.5, fontWeight: FontWeight.w400),
  ),
);

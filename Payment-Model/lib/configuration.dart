import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

ThemeData theme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Color(0xfff6f6f6),
  dividerColor: Color(0xffe2e2e2),
  primarySwatch: Colors.green,
  // primarySwatch: Colors.purple,
  // primaryColor: Colors.green,
  accentColor: Colors.amber,
  backgroundColor: Colors.white,
  secondaryHeaderColor: Colors.grey,
  primaryColorDark: Colors.deepPurple,
  canvasColor: Colors.white,
  fontFamily: 'Cairo',
  textTheme: ThemeData.light().textTheme.copyWith(
        overline: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        caption: TextStyle(color: Color(0xfff6f6f6), fontSize: 14),
        headline1: TextStyle(fontWeight: FontWeight.w800),
        headline2: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        bodyText1: TextStyle(
            color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600),
        headline3:
            TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Product Sans'),
        headline4: TextStyle(fontFamily: 'Product Sans'),
        bodyText2: TextStyle(
            color: Colors.grey, fontFamily: 'Product Sans', fontSize: 14),
      ),
  buttonTheme: ButtonThemeData(
    padding: EdgeInsets.all(0),
  ),
);

// e328e
Iterable<LocalizationsDelegate<dynamic>> localization = [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
];
Iterable<Locale> languages = [
  Locale("ar", "AE"), // OR Locale('ar', 'AE') OR Other RTL locales
  Locale("en", "US"),
];

Locale local = Locale("ar", "AE");

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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

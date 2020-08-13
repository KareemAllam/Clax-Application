// Dart & Other Packages;
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// Providers
import 'package:clax/providers/Auth.dart';
// UI
import 'package:clax/commonUI.dart';
// Screens
import 'package:clax/screens/ClaxRoot.dart';
import 'package:clax/screens/Login/Login.dart';
import 'package:clax/screens/Login/Register.dart';
import 'package:clax/screens/Authentication.dart';
import 'package:clax/screens/Login/resetPassword.dart';
import 'package:clax/screens/Login/ForgotPassword.dart';
import 'package:clax/screens/Login/ForgetVerification.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider())
      ],
      child: Builder(
        builder: (context) => MaterialApp(
          title: 'Clax',
          theme: appTheme,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          // OR Locale('ar', 'AE') OR Other RTL locales
          supportedLocales: [Locale('ar', 'AE')],
          // MaterialApp contains our top-level Navigator
          initialRoute: Authentication.routeName,
          routes: {
            Authentication.routeName: (BuildContext context) =>
                Authentication(),
            Login.routeName: (BuildContext context) => Login(),
            RegisterForm.routeName: (BuildContext context) => RegisterForm(),
            ForgetPass.routeName: (BuildContext context) => ForgetPass(),
            ResetPass.routeName: (BuildContext context) => ResetPass(),
            ForgetVerification.routeName: (BuildContext context) =>
                ForgetVerification(),
            ClaxRoot.routeName: (BuildContext context) => ClaxRoot(),
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

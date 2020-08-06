// Dart & Other Packages;
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// Providers
import 'package:clax/providers/Auth.dart';
// Screens
import 'package:clax/screens/ClaxRoot.dart';
import 'package:clax/screens/Login/Login.dart';
import 'package:clax/screens/Authentication.dart';
import 'package:clax/screens/Login/Register.dart';
import 'package:clax/screens/Login/Register2.dart';
import 'package:clax/screens/Login/resetPassword.dart';
import 'package:clax/screens/Login/ForgotPassword.dart';
// UI
import 'package:clax/commonUI.dart';
import 'package:overlay_support/overlay_support.dart';

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
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: OverlaySupport(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          // OR Locale('ar', 'AE') OR Other RTL locales
          supportedLocales: [Locale('ar', 'AE')],
          title: 'Clax',
          theme: appTheme,
          routes: {
            '/': (BuildContext context) => Authentication(),
            Authentication.routeName: (BuildContext context) =>
                Authentication(),
            Login.routeName: (BuildContext context) => Login(),
            RegisterForm.routeName: (BuildContext context) => RegisterForm(),
            RegisterForm2.routeName: (BuildContext context) => RegisterForm2(),
            ForgetPass.routeName: (BuildContext context) => ForgetPass(),
            ResetPass.routeName: (BuildContext context) => ResetPass(),
            ClaxRoot.routeName: (BuildContext context) => ClaxRoot(),
          },
          // onGenerateRoute: Router.generateRoute,
        ),
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         Provider(create: (context) => AuthProvider()),
//         Provider(create: (context) => ProfilesProvider()),
//         Provider(create: (context) => PaymentProvider()),
//         Provider(create: (context) => ComplainsProvider()),
//         Provider(create: (context) => TripsProvider()),
//         Provider(create: (context) => TripSettingsProvider()),
//         Provider(create: (context) => TrackingProvider()),
//         ChangeNotifierProvider(create: (context) => AuthProvider()),
//         ChangeNotifierProvider(create: (context) => ProfilesProvider()),
//         ChangeNotifierProvider(create: (context) => PaymentProvider()),
//         ChangeNotifierProvider(create: (context) => ComplainsProvider()),
//         ChangeNotifierProvider(create: (context) => TripsProvider()),
//         ChangeNotifierProvider(create: (context) => TrackingProvider()),
//         ChangeNotifierProvider(create: (context) => TripSettingsProvider()),
//       ],
//       child: OverlaySupport(
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           localizationsDelegates: [
//             GlobalMaterialLocalizations.delegate,
//             GlobalWidgetsLocalizations.delegate,
//           ],
//           // OR Locale('ar', 'AE') OR Other RTL locales
//           supportedLocales: [
//             Locale('ar', 'AE')
//           ],
//           title: 'Clax',
//           theme: appTheme,
//           onGenerateRoute: Router.generateRoute,
//         ),
//       ),
//     );
//   }
// }

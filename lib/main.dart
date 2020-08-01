// Dart & Other Packages;
import 'package:clax/Route.dart';
import 'package:clax/commonUI.dart';
import 'package:clax/providers/Family.dart';
import 'package:clax/screens/Login/ForgotPassword.dart';
import 'package:clax/screens/Authentication.dart';
import 'package:clax/screens/Login/Login.dart';
import 'package:clax/screens/Login/Register.dart';
import 'package:clax/screens/Login/resetPassword.dart';
import 'package:clax/screens/ClaxRoot.dart';
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// Providers
import 'package:clax/providers/Auth.dart';

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
                  '/': (BuildContext context) => Authentication(),
                  Authentication.routeName: (BuildContext context) =>
                      Authentication(),
                  Login.routeName: (BuildContext context) => Login(),
                  RegisterForm.routeName: (BuildContext context) =>
                      RegisterForm(),
                  ForgetPass.routeName: (BuildContext context) => ForgetPass(),
                  ResetPass.routeName: (BuildContext context) => ResetPass(),
                  ClaxRoot.routeName: (BuildContext context) {
                    Provider.of<AuthProvider>(context, listen: false)
                        .outerContext = context;
                    return ClaxRoot();
                  },
                },
                debugShowCheckedModeBanner: false,
              )),
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
//         Provider(create: (context) => TransactionsProvider()),
//         Provider(create: (context) => MapProvider()),
//         Provider(create: (context) => CurrentTripProvider()),
//         Provider(create: (context) => FamilyProvider()),
//         ChangeNotifierProvider(create: (context) => AuthProvider()),
//         ChangeNotifierProvider(create: (context) => ProfilesProvider()),
//         ChangeNotifierProvider(create: (context) => PaymentProvider()),
//         ChangeNotifierProvider(create: (context) => ComplainsProvider()),
//         ChangeNotifierProvider(create: (context) => TripsProvider()),
//         ChangeNotifierProvider(create: (context) => TransactionsProvider()),
//         ChangeNotifierProvider(create: (context) => MapProvider()),
//         ChangeNotifierProvider(create: (context) => CurrentTripProvider()),
//         ChangeNotifierProvider(create: (context) => FamilyProvider()),
//       ],
//       child: OverlaySupport(
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           localizationsDelegates: [
//             GlobalMaterialLocalizations.delegate,
//             GlobalWidgetsLocalizations.delegate,
//           ],
//           supportedLocales: [
//             Locale('ar', 'AE')
//           ], // OR Locale('ar', 'AE') OR Other RTL locales

//           title: 'Clax',
//           theme: appTheme,
//           onGenerateRoute: Router.generateRoute,
//         ),
//       ),
//     );
//   }
// }

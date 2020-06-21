// Dart & Other Packages;
import 'package:clax/Route.dart';
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// Providers
// import 'package:clax/providers/CurrentTrip.dart';
import 'package:clax/providers/Complains.dart';
import 'package:clax/providers/Tracking.dart';
import 'package:clax/providers/RideSettings.dart';
import 'package:clax/providers/Payment.dart';
import 'package:clax/providers/Profile.dart';
// import 'package:clax/providers/Trips.dart';
import 'package:clax/providers/Auth.dart';
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
        Provider(create: (context) => ProfilesProvider()),
        Provider(create: (context) => PaymentProvider()),
        Provider(create: (context) => ComplainsProvider()),
        // Provider(create: (context) => TripsProvider()),
        Provider(create: (context) => TripSettingsProvider()),
        // Provider(create: (context) => CurrentTripProvider()),
        Provider(create: (context) => TrackingProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProfilesProvider()),
        ChangeNotifierProvider(create: (context) => PaymentProvider()),
        ChangeNotifierProvider(create: (context) => ComplainsProvider()),
        // ChangeNotifierProvider(create: (context) => TripsProvider()),
        // ChangeNotifierProvider(create: (context) => CurrentTripProvider()),
        ChangeNotifierProvider(create: (context) => TrackingProvider()),
        ChangeNotifierProvider(create: (context) => TripSettingsProvider()),
      ],
      child: OverlaySupport(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('ar', 'AE')
          ], // OR Locale('ar', 'AE') OR Other RTL locales

          title: 'Clax',
          theme: appTheme,
          onGenerateRoute: Router.generateRoute,
        ),
      ),
    );
  }
}

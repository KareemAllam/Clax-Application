// Dart & Other Packages
import 'package:provider/provider.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Utils
import 'package:clax/services/CloudMessaging.dart';
// Providers
import 'package:clax/providers/Auth.dart';
import 'package:clax/providers/Trips.dart';
import 'package:clax/providers/Profile.dart';
import 'package:clax/providers/Payment.dart';
import 'package:clax/providers/Tracking.dart';
import 'package:clax/providers/Complains.dart';
import 'package:clax/providers/RideSettings.dart';
// Route Generators
import 'package:clax/Route.dart';

class ClaxRoot extends StatefulWidget {
  static const routeName = '/ClaxRoot';
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey();
  @override
  _ClaxRootState createState() => _ClaxRootState();
}

class _ClaxRootState extends State<ClaxRoot> {
  NotificationHandler handler = NotificationHandler();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  void _navigateToItemDetail(Map<String, dynamic> message) {
    handler.handle(context, message);
  }

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        _navigateToItemDetail(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        // print("onLaunch: $message");
        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        // print("onResume: $message");
        _navigateToItemDetail(message);
      },
    );
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      // print("Push Messaging token: $token");
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<AuthProvider>(context, listen: false).outerContext = context;
  }

  Future<bool> didPopRoute() async {
    final NavigatorState navigator = widget.navigatorKey.currentState;
    assert(navigator != null);
    return await navigator.maybePop();
  }

  @override
  Widget build(BuildContext context2) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => AuthProvider()),
        Provider(create: (context) => ProfilesProvider()),
        Provider(create: (context) => PaymentProvider()),
        Provider(create: (context) => ComplainsProvider()),
        Provider(create: (context) => TripsProvider()),
        Provider(create: (context) => TripSettingsProvider()),
        Provider(create: (context) => TrackingProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ProfilesProvider()),
        ChangeNotifierProvider(create: (context) => PaymentProvider()),
        ChangeNotifierProvider(create: (context) => ComplainsProvider()),
        ChangeNotifierProvider(create: (context) => TripsProvider()),
        ChangeNotifierProvider(create: (context) => TrackingProvider()),
        ChangeNotifierProvider(create: (context) => TripSettingsProvider()),
      ],
      child: Builder(
        builder: (context) => OverlaySupport(
          // Solution for nested routing was provided here:
          // https://github.com/rmtmckenzie/flutter_nested_navigators
          child: WillPopScope(
            onWillPop: () async {
              return !await didPopRoute();
            },
            child: Navigator(
              key: widget.navigatorKey,
              onGenerateRoute: Router.generateRoute,
            ),
          ),
        ),
      ),
    );
  }
}

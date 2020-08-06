// Dart & Other Packages
import 'package:clax/providers/Auth.dart';
import 'package:provider/provider.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Utils
import 'package:clax/services/CloudMessaging.dart';
// Providers
import 'package:clax/providers/Map.dart';
import 'package:clax/providers/Trips.dart';
import 'package:clax/providers/Family.dart';
import 'package:clax/providers/Profile.dart';
import 'package:clax/providers/Payment.dart';
import 'package:clax/providers/Complains.dart';
import 'package:clax/providers/CurrentTrip.dart';
import 'package:clax/providers/Transactions.dart';
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
        Provider(create: (context) => ProfilesProvider()),
        Provider(create: (context) => PaymentProvider()),
        Provider(create: (context) => ComplainsProvider()),
        Provider(create: (context) => TripsProvider()),
        Provider(create: (context) => TransactionsProvider()),
        Provider(create: (context) => MapProvider()),
        Provider(create: (context) => CurrentTripProvider()),
        Provider(create: (context) => FamilyProvider()),
        ChangeNotifierProvider(create: (context) => ProfilesProvider()),
        ChangeNotifierProvider(create: (context) => PaymentProvider()),
        ChangeNotifierProvider(create: (context) => ComplainsProvider()),
        ChangeNotifierProvider(create: (context) => TripsProvider()),
        ChangeNotifierProvider(create: (context) => TransactionsProvider()),
        ChangeNotifierProvider(create: (context) => MapProvider()),
        ChangeNotifierProvider(create: (context) => CurrentTripProvider()),
        ChangeNotifierProvider(create: (context) => FamilyProvider()),
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

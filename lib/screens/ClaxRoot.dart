// Dart & Other Packages
import 'package:provider/provider.dart';
import 'package:overlay_support/overlay_support.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
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
        Provider(create: (context) => TripSettingsProvider()),
        Provider(create: (context) => TrackingProvider()),
        ChangeNotifierProvider(create: (context) => ProfilesProvider()),
        ChangeNotifierProvider(create: (context) => PaymentProvider()),
        ChangeNotifierProvider(create: (context) => ComplainsProvider()),
        ChangeNotifierProvider(create: (context) => TripsProvider()),
        ChangeNotifierProvider(create: (context) => TrackingProvider()),
        ChangeNotifierProvider(create: (context) => TripSettingsProvider()),
      ],
      child: Builder(
        // Solution for nested routing was provided here:
        // https://github.com/rmtmckenzie/flutter_nested_navigators
        builder: (context) => OverlaySupport(
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

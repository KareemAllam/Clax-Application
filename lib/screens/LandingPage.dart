// Dart & Other Packages
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Models
import 'package:clax/models/CurrentTrip.dart';
import 'package:clax/models/CurrentDriver.dart';
// Services
import 'package:clax/services/CloudMessaging.dart';
// Providers
import 'package:clax/providers/Map.dart';
import 'package:clax/providers/CurrentTrip.dart';
// Components
import 'package:clax/screens/MakeARide/OnATrip.dart';
import 'package:clax/screens/MakeARide/NewRide.dart';
import 'package:clax/screens/MakeARide/RideSearching.dart';

class LandingPage extends StatefulWidget {
  static const routeName = '/';
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  CurrentTrip tripInfo;
  CurrentDriver driverInfo;
  bool onATrip = false;
  bool searching = false;
  String driverId;

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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<MapProvider>(context, listen: false).scaffoldKey = _scaffoldKey;
    Provider.of<CurrentTripProvider>(context, listen: false).scaffoldKey =
        _scaffoldKey;

    tripInfo = Provider.of<CurrentTripProvider>(context).currentTripInfo;
    driverInfo = Provider.of<CurrentTripProvider>(context).currentDriverInfo;
  }

  @override
  Widget build(BuildContext context) {
    searching = tripInfo != null;
    onATrip = driverInfo != null;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Container(
        key: _scaffoldKey,
        child:
            !searching ? StartARide() : onATrip ? OnATrip() : RideSearching(),
      ),
    );
  }
}

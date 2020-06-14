// Dart & Other Packages
import 'package:clax/models/CurrentDriver.dart';
import 'package:clax/models/CurrentTrip.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Utils
import 'package:clax/utils/MessageHandling.dart';
// Providers
import 'package:clax/providers/Map.dart';
import 'package:clax/providers/CurrentTrip.dart';
// Components
import 'package:clax/screens/MakeARide/OnATrip.dart';
import 'package:clax/screens/MakeARide/NewRide.dart';
import 'package:clax/screens/MakeARide/RideSearching.dart';

class Clax extends StatefulWidget {
  static const routeName = '/homescreen';
  @override
  _ClaxState createState() => _ClaxState();
}

class _ClaxState extends State<Clax> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  NotificationHandler handler = NotificationHandler();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  CurrentTrip tripInfo;
  CurrentDriver driverInfo;
  bool onATrip = false;
  bool searching = false;
  String driverId;
  ThemeData theme;

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
    Provider.of<MapProvider>(context, listen: false).scaffoldKey = _scaffoldKey;
    Provider.of<CurrentTripProvider>(context, listen: false).scaffoldKey =
        _scaffoldKey;
    tripInfo = Provider.of<CurrentTripProvider>(context).currentTripInfo;
    driverInfo = Provider.of<CurrentTripProvider>(context).currentDriverInfo;
    theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    searching = tripInfo != null;
    onATrip = driverInfo != null;
    return Container(
      key: _scaffoldKey,
      child: !searching ? StartARide() : onATrip ? OnATrip() : RideSearching(),
    );
  }
}

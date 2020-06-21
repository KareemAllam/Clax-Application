// Dart & Other Packages
import 'package:clax/providers/RideSettings.dart';
import 'package:clax/providers/Tracking.dart';
import 'package:clax/screens/MakeARide/RideSettings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// Main Drawer
import 'package:clax/screens/Drawer.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Utils
import 'package:clax/utils/MessageHandling.dart';
// Components
import 'package:clax/screens/MakeARide/Working.dart';
import 'package:clax/screens/MakeARide/Break.dart';
import 'package:provider/provider.dart';

class Clax extends StatefulWidget {
  static const routeName = '/homescreen';
  @override
  _ClaxState createState() => _ClaxState();
}

class _ClaxState extends State<Clax> with WidgetsBindingObserver {
  // ----- Configuration -----
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  NotificationHandler handler = NotificationHandler();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  // Driver is currenlty taking a break?
  bool working = false;

  void _navigateToItemDetail(Map<String, dynamic> message) {
    handler.handle(context, message);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
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
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<TrackingProvider>(context, listen: false).scaffoldKey =
        _scaffoldKey;
    working = Provider.of<TripSettingsProvider>(context).working;
  }

  changeWorkingState() {
    Provider.of<TripSettingsProvider>(context, listen: false).working =
        !working;
    setState(() => working = !working);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: MainDrawer(),
        appBar: AppBar(
          actions: <Widget>[
            if (working)
              IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(RideSettings.routeName)),
            if (working)
              IconButton(
                  icon: Icon(
                    Icons.free_breakfast,
                    color: Colors.white,
                  ),
                  onPressed: changeWorkingState),
          ],
          elevation: 0.0,
          title: Text(working ? 'على الطريق' : "استراحة",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white)),
        ),
        body: working
            ? Working(changeWorkingState)
            : TakeABreak(changeWorkingState));
  }
}

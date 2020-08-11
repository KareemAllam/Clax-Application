// Dart & Other Packages
import 'package:clax/providers/Profile.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Provider
import 'package:clax/providers/Tracking.dart';
import 'package:clax/providers/RideSettings.dart';
// Screens
import 'package:clax/screens/MakeARide/StartTrip.dart';
// Components
import 'package:clax/screens/MakeARide/Break.dart';
// Services
import 'package:clax/services/CloudMessaging.dart';
// Main Drawer
import 'package:clax/screens/Drawer.dart';

class LandingPage extends StatefulWidget {
  static const routeName = '/';
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with WidgetsBindingObserver {
  // ----- Configuration -----
  final NotificationHandler handler = NotificationHandler();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  // Driver allowed to use the app?
  bool phoneVerified;
  // Driver is currenlty taking a break?
  bool working = false;

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
    Provider.of<TrackingProvider>(context, listen: false).scaffoldKey =
        _scaffoldKey;
    working = Provider.of<TripSettingsProvider>(context).working;
    phoneVerified =
        Provider.of<ProfilesProvider>(context).profile.phoneVerified;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  changeWorkingState(state) {
    Provider.of<TripSettingsProvider>(context, listen: false).working = state;
    setState(() => working = state);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          key: _scaffoldKey,
          drawer: MainDrawer(),
          appBar: AppBar(
            // actions: <Widget>[
            //   if (working)
            //     IconButton(
            //         icon: Icon(Icons.settings),
            //         onPressed: () =>
            //             Navigator.of(context).pushNamed(RideSettings.routeName)),
            //   if (working)
            //     IconButton(
            //         icon: Icon(
            //           Icons.free_breakfast,
            //           color: Colors.white,
            //         ),
            //         onPressed: changeWorkingState),
            // ],
            elevation: 0.0,
            title: Text(working ? 'على الطريق' : "استراحة",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.white)),
          ),
          body: phoneVerified == null
              ? Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(16),
                  child: SpinKitCircle(color: Theme.of(context).primaryColor),
                )
              : working == true
                  ? StartTrip(changeWorkingState)
                  : TakeABreak(changeWorkingState)),
    );
  }
}

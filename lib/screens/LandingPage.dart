// Dart & Other Packages
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Provider
import 'package:clax/providers/Profile.dart';
import 'package:clax/providers/Tracking.dart';
import 'package:clax/providers/RideSettings.dart';
// Screens
import 'package:clax/screens/MakeARide/Working.dart';
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
  TrackingProvider tracking;
  // Driver is currenlty taking a break?
  bool phoneVerified;
  // Driver is currenlty taking a working?
  bool canWork = false;
  bool onGoingTrip = false;
  String tourId;
  String lineName;

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
    Provider.of<TrackingProvider>(context, listen: false).scaffoldKey =
        _scaffoldKey;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    phoneVerified =
        Provider.of<ProfilesProvider>(context).profile.phoneVerified;
    tracking = Provider.of<TrackingProvider>(context);
    canWork = Provider.of<TripSettingsProvider>(context).canWork;
    onGoingTrip = Provider.of<TripSettingsProvider>(context).onGoingTrip;
    if (onGoingTrip == true) {
      lineName =
          Provider.of<TripSettingsProvider>(context).currnetLine.lineName();
      if (lineName == null) lineName = "جاري التحميل";
    } else
      lineName = null;
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

  void canWorkState(currentState) async {
    Provider.of<TripSettingsProvider>(context, listen: false)
        .canWorkState(currentState);
  }

  Future onGoingTripState(bool currentState, String _lineName) async {
    lineName = _lineName;
    Provider.of<TripSettingsProvider>(context, listen: false)
        .onGoingTripState(currentState);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          key: _scaffoldKey,
          drawer: MainDrawer(),
          appBar: AppBar(
            actions: <Widget>[
              // Debugging & Testing  UI
              // IconButton(
              //     icon: Icon(Icons.play_arrow),
              //     onPressed: () {
              //       tracking.enableStreamingCurrentLocation();
              //     }),
              if (onGoingTrip == true)
                IconButton(
                    icon: Icon(Icons.stop),
                    onPressed: () async {
                      await tracking.disableStreamingCurrentLocation();
                    })
            ],
            elevation: 0.0,
            title: Text(
                canWork == true
                    ? lineName == null ? 'على الطريق' : lineName
                    : "استراحة",
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
              : canWork == true
                  ? onGoingTrip == true
                      ? Working()
                      : StartTrip(onGoingTripState, canWorkState)
                  : TakeABreak(canWorkState)),
    );
  }
}

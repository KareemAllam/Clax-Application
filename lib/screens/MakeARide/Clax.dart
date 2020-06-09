// Dart & Other Packages
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Utils
import 'package:clax/utils/MessageHandling.dart';
// Providers
import 'package:clax/providers/Map.dart';
import 'package:clax/providers/CurrentTrip.dart';
// Screens
import 'package:clax/screens/MakeARide/GoogleMap.dart';
// Components
import 'package:clax/screens/MakeARide/Components/RideConfig.dart';
import 'package:clax/screens/MakeARide/Components/RideSearching.dart';
// Widgets
import 'package:clax/screens/MakeARide/widgets/FlipIcon.dart';
// Drawer
import 'package:clax/screens/Drawer.dart';

class Clax extends StatefulWidget {
  static const routeName = '/homescreen';
  @override
  _ClaxState createState() => _ClaxState();
}

class _ClaxState extends State<Clax> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  NotificationHandler handler = NotificationHandler();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
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
    Provider.of<CurrentTripProvider>(context, listen: false).setScaffoldKey =
        _scaffoldKey;
    Provider.of<MapProvider>(context, listen: false).setScaffoldKey =
        _scaffoldKey;
    searching = Provider.of<CurrentTripProvider>(context).searching;
    onATrip = Provider.of<CurrentTripProvider>(context).onATrip;
    theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: Text(
          "",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white),
        )),
        drawer: MainDrawer(),
        body: !searching
            ? PickLocation()
            : onATrip
                ? Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(MapPage.routeName);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          FlipCard(),
                          Text(
                            "تتبع رحلتك",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(fontWeight: FontWeight.bold)
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                    ),
                  )
                : RideSearching());
  }
}

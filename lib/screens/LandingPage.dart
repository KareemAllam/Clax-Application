// Dart & Other Packages
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Provider
import 'package:clax/providers/Tracking.dart';
import 'package:clax/providers/RideSettings.dart';
// Screens
import 'package:clax/screens/MakeARide/StartTrip.dart';
// Components
import 'package:clax/screens/MakeARide/Break.dart';
// Main Drawer
import 'package:clax/screens/Drawer.dart';

class LandingPage extends StatefulWidget {
  static const routeName = '/homescreen';
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with WidgetsBindingObserver {
  // ----- Configuration -----
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // Driver is currenlty taking a break?
  bool working = false;

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

  changeWorkingState(state) {
    Provider.of<TripSettingsProvider>(context, listen: false).working = state;
    setState(() => working = state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: working
            ? StartTrip(changeWorkingState)
            : TakeABreak(changeWorkingState));
  }
}

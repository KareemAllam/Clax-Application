// Dart & Other Packages
import 'package:clax/models/CurrentDriver.dart';
import 'package:clax/models/CurrentTrip.dart';
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Utils
// Providers
import 'package:clax/providers/Map.dart';
import 'package:clax/providers/CurrentTrip.dart';
// Components
import 'package:clax/screens/MakeARide/OnATrip.dart';
import 'package:clax/screens/MakeARide/NewRide.dart';
import 'package:clax/screens/MakeARide/RideSearching.dart';

class LandingPage extends StatefulWidget {
  static const routeName = '/LandingPage';
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
    return Container(
      key: _scaffoldKey,
      child: !searching ? StartARide() : onATrip ? OnATrip() : RideSearching(),
    );
  }
}

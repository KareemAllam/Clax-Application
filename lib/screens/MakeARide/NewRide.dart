// Dart & Other Packages
import 'package:clax/screens/MakeARide/Components/PickLocation.dart';
import 'package:clax/screens/MakeARide/Components/RideSearching.dart';
import 'package:provider/provider.dart';
// Flutter material Components
import 'package:flutter/material.dart';

// Static Data
import 'package:clax/providers/CurrentTrip.dart';
// Screens
import 'package:clax/screens/MakeARide/GoogleMap.dart';
// Components
import 'package:clax/screens/MakeARide/widgets/FlipIcon.dart';

class RidePickLocation extends StatefulWidget {
  static const routeName = "ridePickLocation";
  @override
  _RidePickLocationState createState() => _RidePickLocationState();
}

class _RidePickLocationState extends State<RidePickLocation> {
  bool onATrip = false;
  bool searching = false;
  String driverId;
  ThemeData theme;

  void didChangeDependencies() {
    super.didChangeDependencies();
    searching = Provider.of<CurrentTripProvider>(context).searching;
    onATrip = Provider.of<CurrentTripProvider>(context).onATrip;
    theme = Theme.of(context);
  }

  Widget build(BuildContext context) {
    // print("Searching: $searching");
    // print("Currently on a Trip: $onATrip");
    return !searching
        ? PickLocation()
        : onATrip
            ? GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(MapPage.routeName);
                },
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
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
                            .copyWith(color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                ),
              )
            : RideSearching();
  }
}

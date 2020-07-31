// Dart & Other Pacakges
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Models
import 'package:clax/models/Trip.dart';
// Providers
import 'package:clax/providers/Trips.dart';
// Widgets
import 'package:clax/widgets/null.dart';
import 'package:clax/screens/Home/widgets/tripCard.dart';
// Drawer
import 'package:clax/screens/Drawer.dart';

class Rides extends StatefulWidget {
  static const routeName = '/Rahalatk';
  @override
  _RidesState createState() => _RidesState();
}

class _RidesState extends State<Rides> {
  List<Trip> trips = [];
  // Loading Data Online Animation Hanlders
  bool refreshing = false;

  // Assign Trips Changes to `trips`
  @override
  void didChangeDependencies() {
    trips = Provider.of<TripsProvider>(context).trips;
    super.didChangeDependencies();
  }

  // retreive Trips from server
  Future refresh(BuildContext context) async {
    setState(() {
      refreshing = true;
    });
    bool retreieved =
        await Provider.of<TripsProvider>(context, listen: false).serverData();
    setState(() {
      refreshing = false;
    });
    if (!retreieved)
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "لقد تعذر الوصول للخادم. حاول مره اخرى في وقت لاحق",
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Colors.white),
            strutStyle: StrutStyle(forceStrutHeight: true),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Builder(
              builder: (context) => IconButton(
                  icon: refreshing
                      ? SpinKitThreeBounce(color: Colors.white, size: 15)
                      : Icon(Icons.refresh, color: Colors.white),
                  onPressed: () => refresh(context)),
            )
          ],
          title: Text(
            "رحلاتك السابقة",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white),
          ),
        ),
        drawer: MainDrawer(),
        body: trips == null
            ? Center(
                child: SpinKitCircle(color: Theme.of(context).primaryColor))
            : trips.length == 0
                ? Center(
                    child: NullContent(things: "رحلات"),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) =>
                        TripCard(trips[index], index),
                    itemCount: trips.length,
                    // shrinkWrap: true,
                    controller: ScrollController(),
                    physics: AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                  )

        // bottomNavigationBar: BottomNavigationBar(
        //   onTap: (index) {
        //     setState(() {
        //       currentIndex = index;
        //     });
        //   },
        //   backgroundColor: Theme.of(context).primaryColor,
        //   unselectedItemColor: Colors.white60,
        //   selectedItemColor: Theme.of(context).accentColor,
        //   currentIndex: currentIndex,
        //   // type: BottomNavigationBarType.shifting,
        //   items: [
        //     BottomNavigationBarItem(
        //       backgroundColor: Theme.of(context).primaryColor,
        //       icon: Icon(Icons.history),
        //       title: Text(
        //         'رحلاتك السابقة',
        //         style: TextStyle(
        //             fontFamily: 'Cairo', fontSize: 14.0, color: Colors.white),
        //       ),
        //     ),
        //     BottomNavigationBarItem(
        //       backgroundColor: Theme.of(context).primaryColor,
        //       icon: Icon(Icons.star),
        //       title: Text(
        //         'الرحلات المفضلة',
        //         style: TextStyle(
        //             fontFamily: 'Cairo', fontSize: 14.0, color: Colors.white),
        //       ),
        //     ),
        //   ],
        // ),
        );
  }
}

// Dart & Other Pacakges
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Models
import 'package:clax/models/Trip.dart';
// Providers
import 'package:clax/providers/Trips.dart';
// Components
import 'package:clax/screens/Home/Components/HistoryTrip.dart';
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
  // Bottom Navigation Bar
  int currentIndex = 0;
  List<Map<String, Object>> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      {'page': HistoryTrips(trips), 'title': 'رحلاتك السابقة'},
    ];
  }

  // Assign Trips Changes to `trips`
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    trips = Provider.of<TripsProvider>(context).trips;
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
          _pages[currentIndex]['title'],
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white),
        ),
      ),
      drawer: MainDrawer(),
      body: _pages[currentIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white60,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: currentIndex,
        // type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.history),
            title: Text(
              'رحلاتك السابقة',
              style: TextStyle(
                  fontFamily: 'Cairo', fontSize: 14.0, color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text(
              'الرحلات المفضلة',
              style: TextStyle(
                  fontFamily: 'Cairo', fontSize: 14.0, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// Dart & Other Packages
import 'package:clax/providers/CurrentTrip.dart';
import 'package:clax/providers/Map.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Components
import 'package:clax/screens/Home/Components/favourites.dart';
// Drawer
import 'package:clax/screens/Drawer.dart';
// Screens
import 'package:clax/screens/MakeARide/NewRide.dart';
// Utils
import 'package:clax/utils/MessageHandling.dart';
import 'package:provider/provider.dart';

class Tabs extends StatefulWidget {
  static const routeName = '/homescreen';
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  NotificationHandler handler = NotificationHandler();
  final List<Map<String, Object>> _pages = [
    {'page': RidePickLocation(), 'title': 'رحلة جديدة'},
    {'page': Favourites(), 'title': 'رحلاتك المفضلة'},
  ];
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  // double _cost;

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text(
        _pages[_selectedPageIndex]['title'],
        style:
            Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
      )),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white60,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.airline_seat_recline_extra),
            title: Text(
              'رحلة جديدة',
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

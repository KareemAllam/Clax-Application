// Dart & Other Packages
import 'package:clax/Providers/Trips.dart';
import 'package:clax/screens/MakeARide/StartARide.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Components
import 'package:clax/screens/Home/Components/favourites.dart';
// Widgets
import 'package:clax/widgets/drawer.dart';
// Providers
import 'package:clax/providers/Map.dart';
import 'package:clax/providers/Payment.dart';
// Screens
import 'package:clax/screens/MakeARide/GoogleMap.dart';
import 'package:clax/screens/MakeARide/RidePickupLocation.dart';

class Tabs extends StatefulWidget {
  static const routeName = '/homescreen';
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  final List<Map<String, Object>> _pages = [
    {'page': RidePickLocation(), 'title': 'رحلة جديدة'},
    {'page': Favourites(), 'title': 'رحلاتك المفضلة'},
  ];
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _navigateToItemDetail(Map<String, dynamic> message) {
    // Navigator.of(context).pushNamed(MapPage.routeName);
    // Navigator.of(context)
    //     .print("Route Name: ${ModalRoute.of(context).settings.name}");
    // print("isCurrent: ${ModalRoute.of(context).isCurrent}");
    // print("isActive: ${ModalRoute.of(context).isActive}");
    // print("isFirst: ${ModalRoute.of(context).isFirst}");

    String type = message['data']['type'];
    switch (type) {
      case "driverArrived":
        // Retreive DriverID
        String driverId = message['data']['driverId'];
        Provider.of<TripsProvider>(context, listen: false).setBusy = true;
        Provider.of<MapProvider>(context, listen: false).setDriverId = driverId;
        // Exit Waiting Screen
        // Github Solution
        // https://stackoverflow.com/questions/50817086/how-to-check-which-the-current-route-is/50817399
        if (!ModalRoute.of(context).isCurrent) {
          Navigator.popUntil(context, (route) {
            if (route.settings.name == StartARide.routeName) return false;
            return true;
          });
        }
        Navigator.of(context).pushNamed(MapPage.routeName);
        break;
      case "offer":
        double offerDiscount = double.parse(message['data']['discount']);
        Provider.of<PaymentProvider>(context).setDiscount = offerDiscount;
        break;
      default:
      // Default FCM Action
    }
  }

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        // print("onMessage: $message");
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
  Widget build(BuildContext context) {
    return Scaffold(
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

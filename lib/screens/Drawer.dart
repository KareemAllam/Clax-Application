// Dart & Other Packages
import 'package:clax/providers/Payment.dart';
import 'package:clax/providers/Profile.dart';
import 'package:clax/screens/Authentication.dart';
import 'package:clax/screens/LandingPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Providers
import 'package:clax/providers/Auth.dart';
// import 'package:clax/providers/Trips.dart';
// import 'package:clax/providers/Payment.dart';
// import 'package:clax/providers/Profile.dart';
// import 'package:clax/providers/CurrentTrip.dart';
// import 'package:clax/providers/Transactions.dart';
// Screens
import 'package:clax/screens/ClaxRoot.dart';
import 'package:clax/screens/Rides/Rahalatk.dart';
import 'package:clax/screens/Rides/FreeRides.dart';
import 'package:clax/screens/Help/Help.dart';
import 'package:clax/screens/Settings/Settings.dart';
import 'package:clax/screens/Complains/Complains_Screen.dart';
import 'package:clax/screens/Payments/Payment_HomeScreen.dart';
import 'package:clax/screens/Login/Login.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  List<Map<String, dynamic>> menu = [
    {
      "title": 'كلاكس',
      "icon": Icons.local_taxi,
      "route": LandingPage.routeName
    },
    {"title": 'رحلاتك', "icon": Icons.calendar_today, "route": Rides.routeName},
    {
      "title": 'الرحلات المجانية',
      "icon": Icons.card_giftcard,
      "route": FreeRides.routeName
    },
    {
      "title": 'الدفع',
      "icon": Icons.attach_money,
      "route": PaymentScreen.routeName
    },
    {"title": 'الشكاوي', "icon": Icons.feedback, "route": Complains.routeName},
    {"title": 'الإعدادات', "icon": Icons.settings, "route": Settings.routeName},
    {"title": 'مساعدة', "icon": Icons.help, "route": Help.routeName},
  ];

  void logout() async {
    bool logout =
        await Provider.of<AuthProvider>(context, listen: false).logOut();
    if (logout) {
      // await Provider.of<PaymentProvider>(context, listen: false).init();
      // await Provider.of<ProfilesProvider>(context, listen: false).init();
      // await Provider.of<TripsProvider>(context, listen: false).initialize();
      // await Provider.of<TransactionsProvider>(context, listen: false)
      //     .initialize();
      // await Provider.of<CurrentTripProvider>(context, listen: false).init();

      BuildContext _context =
          Provider.of<AuthProvider>(context, listen: false).outerContext;
      Navigator.of(_context).pop();
      Navigator.of(_context).pushReplacementNamed(Authentication.routeName);

      // // Pop Current Screens
      // Navigator.popUntil(context, (route) {
      //   print(route.settings.name);
      //   if (route.settings.name == "/") return true;
      //   return false;
      // });

      // // Push Login Screen
      // Navigator.of(context).pushNamed(Login.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget buildListTile(String title, IconData icon, Function tapHandler) =>
        Container(
          // decoration: BoxDecoration(
          //     border: Border(top: BorderSide(color: Colors.black12))),
          child: ListTile(
            leading:
                Icon(icon, size: 26, color: Theme.of(context).primaryColor),
            title: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.w600, color: Colors.black45),
            ),
            onTap: tapHandler,
          ),
        );
    String _name =
        Provider.of<ProfilesProvider>(context).profile.name.toString();
    double balance = Provider.of<PaymentProvider>(context).balance;
    return SafeArea(
      child: Drawer(
          child: ListView(
        children: <Widget>[
          // Image.asset(
          //   'assets/images/taxi.png',
          //   fit: BoxFit.fitWidth,
          // ),
          Container(
            padding:
                const EdgeInsets.only(left: 16, top: 32, right: 16, bottom: 16),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: const AssetImage(
                  'assets/images/texture.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo.png',
                    height: 64,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_name,
                              strutStyle: StrutStyle(forceStrutHeight: true),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: Colors.white)),
                          SizedBox(height: 12),
                          Text('$balance جنيه',
                              strutStyle: StrutStyle(forceStrutHeight: true),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Colors.white60)),
                        ],
                      ),
                      Transform.rotate(
                        angle: 22 / 7,
                        child: IconButton(
                            icon: Icon(Icons.exit_to_app),
                            padding: EdgeInsets.all(0),
                            alignment: Alignment.centerRight,
                            onPressed: logout,
                            color: Colors.white),
                      )
                    ],
                  ),
                ]),
          ),
          ...menu.map((index) => buildListTile(
                index['title'],
                index['icon'],
                () {
                  // Get Current Route Name
                  String currentRoute = ModalRoute.of(context).settings.name;
                  // () => Clax
                  if (index['route'] == LandingPage.routeName) {
                    // Clax => Clax
                    if (currentRoute == LandingPage.routeName) {
                      // Dismiss Drawer
                      Navigator.of(context).pop();
                      return;
                    } else {
                      // Dismiss Drawer
                      Navigator.of(context).pop();
                      // Item => Clax
                      Navigator.of(context).pop();
                      // Navigator.of(context)
                      //     .pop(index['route']);
                      return;
                    }
                  }
                  // Item => Item
                  else if (currentRoute == index['route']) {
                    // Dismiss Drawer
                    Navigator.of(context).pop();
                    return;
                  }
                  // Navigating to Different Screen
                  if (currentRoute == LandingPage.routeName) {
                    // Dismiss Drawer
                    Navigator.of(context).pop();
                    // Navigate to Screen
                    Navigator.of(context).pushNamed(index['route']);
                  }
                  // "Item => Item2"
                  else {
                    // Dismiss Drawer
                    Navigator.of(context).pop();
                    // Navigate to Screen
                    Navigator.of(context).pushReplacementNamed(index['route']);
                  }
                },
              )),
        ],
      )),
    );
  }
}

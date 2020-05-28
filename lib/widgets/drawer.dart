// Flutter's Material Components
import 'package:flutter/material.dart';
// Screens
import 'package:clax/screens/MakeARide/Clax.dart';
import 'package:clax/screens/Home/Rahalatk.dart';
import 'package:clax/screens/Home/free_rides.dart';
import 'package:clax/screens/Help/Help.dart';
import 'package:clax/screens/Settings/Settings.dart';
import 'package:clax/screens/Payments/Complains_Screen.dart';
import 'package:clax/screens/Payments/Payment_HomeScreen.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  List<Map<String, dynamic>> menu = [
    {"title": 'كلاكس', "icon": Icons.local_taxi, "route": Tabs.routeName},
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
  @override
  Widget build(BuildContext context) {
    Widget buildListTile(String title, IconData icon, Function tapHandler) =>
        Container(
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.black12))),
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

    return SafeArea(
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/images/taxi.png',
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            ...menu.map((index) => buildListTile(
                  index['title'],
                  index['icon'],
                  () {
                    // Get Current Route Name
                    String currentRoute = ModalRoute.of(context).settings.name;
                    // If App is on the Homescreen
                    if (currentRoute == '/homescreen') {
                      // Dismiss Drawer
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(index['route']);
                      return;
                    }
                    // If App is on a Screen and User is navigating to Homescreen
                    if (currentRoute == '/homepage') {
                      // Dismiss Drawer
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      return;
                    }
                    // If App is on a Screen and User is navigating to the same screen
                    if (currentRoute == index['route']) {
                      // Dismiss Drawer
                      Navigator.of(context).pop();
                      return;
                    }
                    // Dismiss Drawer
                    Navigator.of(context).pop();
                    // Navigate to Screen
                    Navigator.of(context).pushReplacementNamed(index['route']);
                  },
                )),
            // Spacer(),
            // Padding(
            //     padding: EdgeInsets.only(bottom: 20, right: 20),
            //     child: Text(
            //       "v1.23",
            //       style: TextStyle(color: Colors.grey),
            //     ))
          ],
        ),
      ),
    );
  }
}

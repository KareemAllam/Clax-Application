// Dart & Other Packages
// import 'package:image_picker/image_picker.dart';
// Flutter's Material Components
import 'package:clax/screens/Payments/Payment_HomeScreen.dart';
import 'package:flutter/material.dart';
// Screens
import 'package:clax/screens/Home/Clax.dart';
import 'package:clax/screens/Home/Rahalatk.dart';
import 'package:clax/screens/Home/free_rides.dart';
import 'package:clax/screens/Home/help.dart';
import 'package:clax/screens/Home/settings.dart';

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
              'assets/images/taxi.jpg',
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            ...menu.map((index) => buildListTile(
                  index['title'],
                  index['icon'],
                  () {
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

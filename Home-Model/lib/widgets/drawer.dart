import 'package:clax/screens/Pay.dart';
import '../screens/Rahalatk.dart';
import '../screens/free_rides.dart';
import '../screens/help.dart';
import '../screens/settings.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    Widget buildListTile(String title, IconData icon, Function tapHandler) {
      return ListTile(
        leading: Icon(icon, size: 26, color: Theme.of(context).primaryColor),
        title: Text(
          title,
          style: new TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
              fontFamily: 'Cairo',
              color: Colors.black45),
        ),
        onTap: tapHandler,
      );
    }

    return Drawer(
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/images/taxi.jpg',
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(
            'كلاكس',
            Icons.local_taxi,
            () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          buildListTile(
            'رحلاتك',
            Icons.calendar_today,
            () {
              Navigator.of(context).pushReplacementNamed(Rides.routeName);
            },
          ),
          buildListTile(
            'الرحلات المجانية',
            Icons.card_giftcard,
            () {
              Navigator.of(context).pushReplacementNamed(FreeRides.routeName);
            },
          ),
          buildListTile(
            'الدفع',
            Icons.attach_money,
            () {
              Navigator.of(context).pushReplacementNamed(Pay.routeName);
            },
          ),
          buildListTile(
            'الإعدادات',
            Icons.settings,
            () {
              Navigator.of(context).pushReplacementNamed(Settings.routeName);
            },
          ),
          buildListTile(
            'مساعدة',
            Icons.help,
            () {
              Navigator.of(context).pushReplacementNamed(Help.routeName);
            },
          ),
        ],
      ),
    );
  }
}

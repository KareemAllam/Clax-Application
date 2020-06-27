import 'package:clax/widgets/appBar.dart';
import 'package:clax/widgets/listTile.dart';

import '../screens/yourAcc.dart';
import '../screens/Notifications.dart';
import '../screens/Safety.dart';
import '../screens/Signout.dart';
import '../widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'Components/Family.dart';

class Settings extends StatelessWidget {
  static const routeName = '/settings';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'الإعدادات'),
      drawer: MainDrawer(),
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        controller: ScrollController(),
        children: <Widget>[
          buildListTile(
            context,
            'الحساب',
            Icons.person_pin,
            () {
              Navigator.of(context).pushNamed(YourAccount.routeName);
            },
          ),
          buildListTile(
            context,
            'الأمان',
            Icons.security,
            () {
              Navigator.of(context).pushNamed(Safety.routeName);
            },
          ),
          buildListTile(
            context,
            'العائلة',
            Icons.person_add,
            () {
              Navigator.of(context).pushNamed(Family.routeName);
            },
          ),
          buildListTile(
            context,
            'الإشعارات',
            Icons.notifications,
            () {
              Navigator.of(context).pushNamed(Notifications.routeName);
            },
          ),
          buildListTile(
            context,
            'تسجيل خروج',
            Icons.power_settings_new,
            () {
              Navigator.of(context).pushReplacementNamed(Signout.routeName);
            },
          ),
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }
}
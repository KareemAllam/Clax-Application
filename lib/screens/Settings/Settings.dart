// Flutter's Material Components
import 'package:flutter/material.dart';
// Screen
import 'package:clax/screens/Settings/AccountOverview.dart';
import 'package:clax/screens/Settings/Notifications.dart';
import 'package:clax/screens/Settings/Safety.dart';
// Components
import 'package:clax/screens/Settings/Family.dart';
// Widgets
import 'package:clax/widgets/appBar.dart';
import 'package:clax/widgets/listTile.dart';
// Drawer
import 'package:clax/screens/Drawer.dart';

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
              Navigator.of(context).pushNamed(AccountOverview.routeName);
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
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }
}

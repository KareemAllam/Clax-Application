// Dart & Other Packages
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Screen
import 'package:clax/screens/Settings/Family.dart';
import 'package:clax/screens/Settings/Safety.dart';
import 'package:clax/screens/Settings/Notifications.dart';
import 'package:clax/screens/Settings/AccountOverview.dart';
// Components
import 'package:clax/screens/Settings/FamilyPreviews.dart';
// Widgets
import 'package:clax/widgets/Cards.dart';
// Providers
import 'package:clax/providers/Family.dart';
// Drawer
import 'package:clax/screens/Drawer.dart';

class Settings extends StatelessWidget {
  static const routeName = '/settings';
  @override
  Widget build(BuildContext context) {
    bool seen =
        Provider.of<FamilyProvider>(context, listen: false).seenAlready();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('الإعدادات',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white)),
      ),
      drawer: MainDrawer(),
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        controller: ScrollController(),
        children: <Widget>[
          Cards.listTile(
            context,
            title: 'الحساب',
            icon: Icons.person_pin,
            tapHandler: () {
              Navigator.of(context).pushNamed(AccountOverview.routeName);
            },
          ),
          Cards.listTile(
            context,
            title: 'الأمان',
            icon: Icons.security,
            tapHandler: () {
              Navigator.of(context).pushNamed(Safety.routeName);
            },
          ),
          Cards.listTile(
            context,
            title: 'العائلة',
            icon: Icons.person_add,
            tapHandler: () {
              seen
                  ? Navigator.of(context).pushNamed(Members.routeName)
                  : Navigator.of(context).pushNamed(Family.routeName);
            },
          ),
          Cards.listTile(
            context,
            title: 'الإشعارات',
            icon: Icons.notifications,
            tapHandler: () {
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

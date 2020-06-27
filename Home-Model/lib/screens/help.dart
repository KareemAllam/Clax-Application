import 'package:clax/widgets/appBar.dart';
import 'package:clax/widgets/listTile.dart';

import '../screens/Bookings.dart';
import '../screens/Guide.dart';
import '../screens/More.dart';
import '../screens/Payments.dart';
import '../widgets/drawer.dart';
import 'package:flutter/material.dart';

class Help extends StatelessWidget {
  static const routeName = '/help';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'مساعدة'),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          buildListTile(
            context,
            'المدفوعات والإيصالات',
            Icons.payment,
            () {
              Navigator.of(context).pushNamed(Payments.routeName);
            },
          ),
          buildListTile(
            context,
            'مشاويرك',
            Icons.gps_fixed,
            () {
              Navigator.of(context).pushNamed(Bookings.routeName);
            },
          ),
          buildListTile(
            context,
            'الإرشادات',
            Icons.live_help,
            () {
              Navigator.of(context).pushNamed(Guide.routeName);
            },
          ),
          buildListTile(
            context,
            'أخرى',
            Icons.info,
            () {
              Navigator.of(context).pushNamed(More.routeName);
            },
          ),
        ],
      ),
    );
  }
}

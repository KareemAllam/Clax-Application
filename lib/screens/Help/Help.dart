// Flutter's Material Components
import 'package:clax/widgets/Cards.dart';
import 'package:flutter/material.dart';
// Screens
import 'package:clax/screens/Help/Bookings.dart';
import 'package:clax/screens/Help/Guide.dart';
import 'package:clax/screens/Help/More.dart';
import 'package:clax/screens/Help/Payments.dart';
// Widgets
import 'package:clax/screens/Drawer.dart';

class Help extends StatelessWidget {
  static const routeName = '/help';
  final List<Map<String, dynamic>> menu = [
    {
      "title": "المدفوعات والإيصالات",
      "route": Payments.routeName,
      "icon": Icons.payment
    },
    {
      "title": "مشاويرك",
      "route": Bookings.routeName,
      "icon": Icons.directions_bus
    },
    {"title": "الإرشادات", "route": Guide.routeName, "icon": Icons.live_help},
    {"title": "أخرى", "route": More.routeName, "icon": Icons.info}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('مساعده',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white)),
      ),
      drawer: MainDrawer(),
      body: ListView.builder(
        itemBuilder: (context, index) => Cards.listTile(
          context,
          title: menu[index]["title"],
          icon: menu[index]["icon"],
          tapHandler: () =>
              Navigator.of(context).pushNamed(menu[index]["route"]),
        ),
        itemCount: menu.length,
        controller: ScrollController(),
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      ),
    );
  }
}

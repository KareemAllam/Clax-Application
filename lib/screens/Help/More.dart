// Flutter's Material Components
import 'package:flutter/material.dart';
// Widgets
import 'package:clax/widgets/appBar.dart';
import 'package:clax/widgets/listTile.dart';

class More extends StatelessWidget {
  static const routeName = '/More';
  final List<Map<String, dynamic>> menu = [
    {
      "title": "توصيلات كلاكس",
      "icon": Icons.directions_bus
      // "route": delivery.routeName
    },
    {
      "title": "رحلة خاصة",
      "icon": Icons.drive_eta
      // "route": privateTrip.routeName
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'أخرى'),
      body: ListView.builder(
        itemBuilder: (context, index) => buildListTile(
          context,
          menu[index]["title"],
          menu[index]["icon"],
          () => Navigator.of(context).pushNamed(menu[index]["route"]),
        ),
        itemCount: menu.length,
        controller: ScrollController(),
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      ),
    );
  }
}

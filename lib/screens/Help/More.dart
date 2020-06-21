// Flutter's Material Components
import 'package:flutter/material.dart';
// Widgets
import 'package:clax/widgets/Cards.dart';

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
      appBar: AppBar(
        elevation: 0.0,
        title: Text('اخرى',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white)),
      ),
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

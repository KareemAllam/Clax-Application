// Flutter's Material Components
import 'package:flutter/material.dart';
// Widgets
import 'package:clax/widgets/Cards.dart';

class Bookings extends StatelessWidget {
  static const routeName = '/Bookings';
  final List<Map<String, dynamic>> menu = [
    {
      "title": "إضافة أو حذف موقع",
      // "route": addLoc.routeName
    },
    {
      "title": "حجز رحلة",
      // "route": bookTrip.routeName
    },
    {
      "title": "الإلغاء",
      // "route": cancellations.routeName
    },
    {
      "title": "تعديل الحجز",
      // "route": editTrip.routeName
    },
    {
      "title": "عرض الرحلة",
      // "route": viewTrip.routeName
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('مشاويرك',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white)),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => Cards.listTile1(
          context,
          title: menu[index]['title'],
          tapHandler: () {
            // Navigator.of(context).pushNamed(editTrip.routeName);
          },
        ),
        itemCount: menu.length,
        controller: ScrollController(),
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      ),
    );
  }
}

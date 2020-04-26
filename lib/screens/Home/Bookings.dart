// Flutter's Material Components
import 'package:flutter/material.dart';
// Widgets
import 'package:clax/widgets/appBar.dart';
import 'package:clax/widgets/listTile.dart';

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
      appBar: buildAppBar(context, 'مشاويرك'),
      body: ListView.builder(
        itemBuilder: (context, index) => buildListTile1(
          context,
          menu[index]['title'],
          () {
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

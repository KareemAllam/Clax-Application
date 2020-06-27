import 'package:clax/widgets/appBar.dart';
import 'package:clax/widgets/listTile.dart';
import 'package:flutter/material.dart';

class Bookings extends StatelessWidget {
  static const routeName = '/Bookings';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'مشاويرك'),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          buildListTile1(
            context,
            'إضافة أو حذف موقع',
            () {
              //Navigator.of(context).pushNamed(addLoc.routeName);
            },
          ),
          buildListTile1(
            context,
            'حجز رحلة',
            () {
              //Navigator.of(context).pushNamed(bookTrip.routeName);
            },
          ),
          buildListTile1(
            context,
            ' الإلغاء',
            () {
              // Navigator.of(context).pushNamed(cancellations.routeName);
            },
          ),
          buildListTile1(
            context,
            'تعديل الحجز',
            () {
              // Navigator.of(context).pushNamed(editTrip.routeName);
            },
          ),
          buildListTile1(
            context,
            ' عرض الرحلة',
            () {
              // Navigator.of(context).pushNamed(viewTrip.routeName);
            },
          ),
        ],
      ),
    );
  }
}

import 'package:clax/widgets/appBar.dart';
import 'package:clax/widgets/listTile.dart';
import 'package:flutter/material.dart';

class More extends StatelessWidget {
  static const routeName = '/More';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'أخرى'),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          buildListTile1(
            context,
            'توصيلات كلاكس',
            () {
              // Navigator.of(context).pushNamed(delivery.routeName);
            },
          ),
          buildListTile1(
            context,
            ' رحلة خاصة',
            () {
              // Navigator.of(context).pushNamed(privateTrip.routeName);
            },
          ),
        ],
      ),
    );
  }
}

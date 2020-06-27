import 'package:clax/widgets/appBar.dart';
import 'package:clax/widgets/listTile.dart';
import 'package:flutter/material.dart';

class Guide extends StatelessWidget {
  static const routeName = '/Guide';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'الإرشادات'),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          buildListTile1(
            context,
            'مكآفات كلاكس',
            () {
              // Navigator.of(context).pushNamed(rewards.routeName);
            },
          ),
          buildListTile1(
            context,
            'عن كلاكس',
            () {
              // Navigator.of(context).pushNamed(about.routeName);
            },
          ),
          buildListTile1(
            context,
            'كيف تتعامل مع السائق',
            () {
              // Navigator.of(context).pushNamed(driver.routeName);
            },
          ),
          buildListTile1(
            context,
            ' اخفاء المكالمات',
            () {
              // Navigator.of(context).pushNamed(hideCalls.routeName);
            },
          ),
          buildListTile1(
            context,
            'خيارات الدفع',
            () {
              // Navigator.of(context).pushNamed(payOptions.routeName);
            },
          ),
          buildListTile1(
            context,
            ' كيفية إدارة حسابي',
            () {
              // Navigator.of(context).pushNamed(accManagement.routeName);
            },
          ),
        ],
      ),
    );
  }
}

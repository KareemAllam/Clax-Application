import 'package:clax/widgets/appBar.dart';
import 'package:clax/widgets/switchListTile.dart';
import 'package:flutter/material.dart';
//import '../widgets/drawer.dart';

class Notifications extends StatefulWidget {
  static const routeName = '/Notifications';

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool _not1 = false;
  bool _not2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'الإشعارات'),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                buildSwitchListTile(
                  context,
                  'العروض الخاصه',
                  'عند وجود عروض أو رحلات مجانية',
                  _not1,
                  (newValue) {
                    setState(
                      () {
                        _not1 = newValue;
                      },
                    );
                  },
                ),
                buildSwitchListTile(
                  context,
                  'تتبع الرحلة',
                  'تتبع خطوات الرحلة',
                  _not2,
                  (newValue) {
                    setState(
                      () {
                        _not2 = newValue;
                      },
                    );
                  },
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20),
                  child: Text('سيتم وصول الإشعارات عند التفعيل',
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            color: Colors.black54,
                          )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

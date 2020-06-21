// Flutter's Material Components
import 'package:flutter/material.dart';
// Widgets
import 'package:clax/widgets/Cards.dart';

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
      appBar: AppBar(
        elevation: 0.0,
        title: Text('الإشعارات',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white)),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                Cards.switchListTile(
                    context: context,
                    title: 'العروض الخاصه',
                    description: 'عند وجود عروض أو رحلات مجانية',
                    currentValue: _not1,
                    updatedValue: (newValue) {
                      setState(
                        () {
                          _not1 = newValue;
                        },
                      );
                    }),
                Cards.switchListTile(
                  context: context,
                  title: 'تتبع الرحلة',
                  description: 'تتبع خطوات الرحلة',
                  currentValue: _not2,
                  updatedValue: (newValue) {
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

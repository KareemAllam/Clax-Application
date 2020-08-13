// Flutter's Material Components
import 'package:clax/providers/Trips.dart';
import 'package:flutter/material.dart';
// Widgets
import 'package:clax/widgets/Cards.dart';
import 'package:provider/provider.dart';

class Notifications extends StatefulWidget {
  static const routeName = '/Notifications';

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool offersNotification = false;
  bool safetyTracking = false;
  @override
  void initState() {
    super.initState();
    offersNotification = Provider.of<TripsProvider>(context).offersNotification;
  }

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
                    currentValue: offersNotification,
                    updatedValue: (bool newValue) {
                      setState(
                        () {
                          offersNotification = newValue;
                          Provider.of<TripsProvider>(context)
                              .changeOffersNotification(newValue);
                        },
                      );
                    }),
                Cards.switchListTile(
                  context: context,
                  title: 'تتبع الرحلة',
                  description: 'اسمح لافراد عائلتك بتتبعك في اي وقت',
                  currentValue: safetyTracking,
                  updatedValue: null,
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

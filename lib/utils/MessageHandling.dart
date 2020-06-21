// Dart & Other Packages
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Providers
import 'package:clax/providers/Payment.dart';
// import 'package:clax/providers/CurrentTrip.dart';
// import 'package:clax/providers/Map.dart';
// // Screens
// import 'package:clax/screens/MakeARide/GoogleMap.dart';
// import 'package:clax/screens/MakeARide/RideConfig.dart';

class NotificationHandler {
  BuildContext context;
  void handle(BuildContext navigator, Map<String, dynamic> message) async {
    // print(ModalRoute.of(navigator).settings.name);
    context = navigator;
    String type = message['data']['type'];
    switch (type) {
      // case "driverArrived":
      //   print("driverArrived");
      //   // await driverArrived(message['data']['driverId']);
      //   break;
      case "offer":
        offer(message['data']['discount']);
        break;
      default:
        // defaultAction(message);
        break;
      // Default FCM Action
    }
  }

  void defaultAction(message) {
    // Parse Notification Data
    // print(message);
    String title = message["notification"]['title'];
    String body = message["notification"]['body'];
    String data = '';
    Map<String, dynamic> _ = Map<String, dynamic>.from(message['data']);
    List<String> keys = [];
    List<dynamic> vals = [];
    Widget table;

    _.forEach((key, value) {
      keys.add(key);
      vals.add(value);
    });
    table = Row(children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: keys
            .map(
              (e) => Text(
                e,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.grey),
              ),
            )
            .toList(),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: vals
            .map(
              (e) => Text(
                e,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.grey),
              ),
            )
            .toList(),
      )
    ]);
    // set up the AlertDialog
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.transparent,
              title: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                padding:
                    EdgeInsets.only(top: 20, right: 15, left: 15, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "وصلت رساله!",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(height: 2),
                    Column(
                      children: <Widget>[
                        Text(title ?? "Notification Title",
                            style: Theme.of(context).textTheme.bodyText2),
                        Text(body ?? "Notification Body",
                            style: Theme.of(context).textTheme.subtitle2),
                        Text(
                          data,
                        ),
                        table
                      ],
                    )
                  ],
                ),
              ),
              buttonPadding: EdgeInsets.all(0),
              actionsPadding: EdgeInsets.all(0),
              titlePadding: EdgeInsets.all(0),
              contentPadding: EdgeInsets.all(0),
            ));
  }
  // Future driverArrived(String driverId) async {
  //   // Retreive DriverID
  //   String _driverId = driverId;
  //   await Provider.of<CurrentTripProvider>(context, listen: false)
  //       .setDriverInfo(_driverId);
  //   Provider.of<MapProvider>(context, listen: false).setDriverId = _driverId;
  //   Provider.of<PaymentProvider>(context, listen: false).setBalance =
  //       -tripPrice;
  //   // Exit Waiting Screen
  //   // Github Solution: https://stackoverflow.com/questions/50817086/how-to-check-which-the-current-route-is/50817399
  //   if (!ModalRoute.of(context).isCurrent) {
  //     Navigator.of(context).popUntil((route) {
  //       if (route.settings.name == StartARide.routeName) return false;
  //       return true;
  //     });
  //   }
  //   Navigator.of(context).pushNamed(MapPage.routeName);
  // }

  void offer(dynamic discount) {
    double offerDiscount = double.parse(discount['value'].toString());
    String type;
    if (discount['type'] == ['percent'])
      type = 'percent';
    else
      type = 'amount';
    Provider.of<PaymentProvider>(context).setDiscount(offerDiscount, type);
  }
}

// Dart & Other Packages
import 'package:clax/providers/RideSettings.dart';
import 'package:provider/provider.dart';
import 'package:clax/screens/MakeARide/widgets/Alert.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';

class NotificationHandler {
  BuildContext context;
  void handle(BuildContext navigator, Map<String, dynamic> message) async {
    // print(ModalRoute.of(navigator).settings.name);
    context = navigator;
    String type = message['data']['type'];
    switch (type) {
      case "tripRequest":
        bool working =
            Provider.of<TripSettingsProvider>(context, listen: false).working;
        if (working) {
          int currentSeats =
              Provider.of<TripSettingsProvider>(context, listen: false)
                  .currnetSeats;
          int requiredSeats = int.parse(message['data']['seats']);
          if (currentSeats + requiredSeats <= 12)
            showRequestDialog(
              context,
              message,
            );
        }
        break;
      default:
        defaultAction(message);
        break;
      // Default FCM Action
    }
  }

  void defaultAction(message) {
    // Parse Notification Data
    print(message);
    String title = message["notification"]['title'];
    String body = message["notification"]['body'];
    String data = '';
    Map<String, dynamic> _ = Map<String, dynamic>.from(message['data']);
    List<Widget> attrbs = [];
    _.forEach((key, value) => attrbs.add(Text(
          '$key: $value',
          style: Theme.of(context).textTheme.caption,
        )));
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
                        Column(children: attrbs)
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
}

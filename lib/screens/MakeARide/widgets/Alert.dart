// Dart & Other Packages
import 'dart:async';
import 'dart:convert';
import 'package:clax/models/PassengerInfo.dart';
import 'package:clax/providers/Tracking.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Providers
import 'package:clax/providers/RideSettings.dart';

// Widgets
import 'package:clax/widgets/CircleTimer.dart';

showRequestDialog(BuildContext context, Map message) {
  // Required Params
  String lineId =
      Provider.of<TripSettingsProvider>(context, listen: false).currnetLine.id;
  String requestId = message['data']['request'];

  // Timeout
  Timer time = Timer.periodic(Duration(seconds: 10), (Timer timer) {
    FirebaseDatabase.instance
        .reference()
        .child("clax-requests/$lineId/$requestId")
        .update({"status": "refused"});
    Navigator.of(context).pop();
    timer.cancel();
  });

  // Dialog Buttons
  Widget cancelButton = FlatButton(
    child: Text("رفض",
        style: TextStyle(color: Colors.white60, fontWeight: FontWeight.bold)),
    onPressed: () {
      time.cancel();
      FirebaseDatabase.instance
          .reference()
          .child("clax-requests/$lineId/$requestId")
          .update({"status": "refused"});
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text("قبول",
        style: TextStyle(
            color: Theme.of(context).accentColor, fontWeight: FontWeight.bold)),
    onPressed: () async {
      time.cancel();
      FirebaseDatabase.instance
          .reference()
          .child("clax-requests/$lineId/$requestId")
          .update({"status": "accpeted"});
      List<double> coords =
          List<double>.from(json.decode(message['data']['station_location']));
      Provider.of<TrackingProvider>(context, listen: false)
          .addPassenger(PassengerInfo(
        message['data']['station_name'],
        LatLng.fromJson(coords),
        int.parse(message['data']['seats']),
      ));

      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    elevation: 1,
    backgroundColor: Colors.transparent,
    title: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5))),
      padding: EdgeInsets.only(top: 15, right: 15, left: 15, bottom: 20),
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Transform.rotate(
                    angle: 45,
                    child: Icon(Icons.pan_tool,
                        color: Color(0xffd6a57c), size: 20),
                  ),
                  SizedBox(width: 8),
                  Text(
                    message['notification']["title"],
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  )
                ],
              ),
              Text(message['notification']["body"],
                  style: Theme.of(context).textTheme.caption),
              Divider(color: Colors.grey[350], height: 8),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("مكان الانتظار:",
                              style: Theme.of(context).textTheme.caption),
                          Text("عدد الركاب:",
                              style: Theme.of(context).textTheme.caption),
                        ],
                      ),
                      SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(message["data"]['station_name'],
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: Colors.black87)),
                          Text(message["data"]['seats'],
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: Colors.black87)),
                        ],
                      )
                    ],
                  ),
                  CircleTimer()
                ],
              )
            ],
          ),
        ],
      ),
    ),
    buttonPadding: EdgeInsets.all(0),
    actionsPadding: EdgeInsets.all(0),
    titlePadding: EdgeInsets.all(0),
    contentPadding: EdgeInsets.all(0),
    content: Container(
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            continueButton,
            cancelButton,
          ],
        )),
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

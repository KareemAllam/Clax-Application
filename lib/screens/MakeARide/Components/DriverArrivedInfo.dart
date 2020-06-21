import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class DriverArrivedInfo extends StatelessWidget {
  final Map driverInfo;
  DriverArrivedInfo(this.driverInfo);
  @override
  Widget build(BuildContext context) {
    Timer time =
        Timer(Duration(seconds: 5), () => Navigator.of(context).pop(true));
    // Buttons Setup
    Widget cancelButton = FlatButton(
        child: Text("الغاء",
            style: TextStyle(
                color: Colors.white60,
                fontWeight: FontWeight.bold)), // Dismiss the Alert Dialoge Box
        onPressed: () {
          time.cancel();
          Navigator.pop(context, false);
        });

    Widget continueButton = FlatButton(
        child: Text("نعم",
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold)),
        onPressed: () {
          Navigator.pop(context, true);
          time.cancel();
        });

    Uint8List img = Uint8List.fromList(
        List<int>.from(driverInfo['profilePic']['data']['data']));

    return AlertDialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      title: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.info,
                      color: Theme.of(context).accentColor,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "تأكيد الرحلة",
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.values[5]),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(children: <Widget>[
                  Flexible(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "اسم السائق:",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(color: Colors.grey),
                              ),
                              Text(
                                "موعد الوصول:",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(color: Colors.grey),
                              )
                            ],
                          ),
                          SizedBox(width: 4),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${driverInfo['name']['first']} ${driverInfo['name']['last']}',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Text(driverInfo['duration'],
                                  style: Theme.of(context).textTheme.bodyText2)
                            ],
                          )
                        ])
                      ],
                    ),
                  ),
                  Flexible(flex: 1, child: Image.memory(img))
                ]),
              )
            ],
          )),
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
  }
}

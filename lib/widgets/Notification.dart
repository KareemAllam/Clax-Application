// Dart & Other Pacakges
import 'package:overlay_support/overlay_support.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Widgets
import 'package:clax/widgets/CircleTimer.dart';

showNotification(BuildContext context, String title, String subtitle,
    {Function cb, Widget trailing}) {
  showOverlayNotification(
      (contex) => SafeArea(
            child: GestureDetector(
              onTap: cb,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(title,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith()),
                          Text(subtitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: Colors.black45))
                        ],
                      ),
                      trailing ??
                          Image.asset(
                            'assets/images/logo.png',
                            height: 40,
                          )
                    ]),
              ),
            ),
          ),
      duration: Duration(seconds: 3));
}

showRequestNotification(BuildContext context, String title, String subtitle,
    {Function cb, Widget trailing}) {
  showOverlayNotification(
    (contex) => SafeArea(
      child: GestureDetector(
          onTap: cb,
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 10),
            // height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(title,
                          style:
                              Theme.of(context).textTheme.subtitle2.copyWith()),
                      Text(subtitle,
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: Colors.black45)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          RaisedButton(
                              elevation: 0,
                              highlightElevation: 0,
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(
                                "قبول",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.green),
                          SizedBox(width: 8),
                          RaisedButton(
                              elevation: 0,
                              highlightElevation: 0,
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(
                                "رفض",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.red)
                        ],
                      )
                    ],
                  ),
                  CircleTimer(),
                ]),
          )),
    ),
    duration: Duration(seconds: 10),
  );
}

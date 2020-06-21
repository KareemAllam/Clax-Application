import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clax/providers/Tracking.dart';

class RetryPermission extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Icon(Icons.location_on,
                  size: 32, color: Theme.of(context).primaryColor),
              SizedBox(height: 8),
              Text("برجاء تشغيل خدمه تحديد المواقع لديك",
                  style: TextStyle(color: Colors.grey)),
              SizedBox(
                  height: 32,
                  child: Divider(
                    endIndent: 50,
                    indent: 50,
                  )),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap:
                          Provider.of<TrackingProvider>(context, listen: false)
                              .getCurrentLocation,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Theme.of(context).primaryColor),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.refresh, color: Colors.white, size: 20),
                            SizedBox(width: 4),
                            Text("إعادة المحاولة",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ])
            ]),
      ),
    );
  }
}

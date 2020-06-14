import 'package:clax/screens/MakeARide/GoogleMap.dart';
import 'package:clax/screens/MakeARide/widgets/FlipIcon.dart';
import 'package:flutter/material.dart';

class OnATrip extends StatefulWidget {
  @override
  _OnATripState createState() => _OnATripState();
}

class _OnATripState extends State<OnATrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('تابع رحلتك',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white)),
        ),
        body: Container(
          color: Colors.white,
          width: double.infinity,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(MapPage.routeName);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FlipCard(),
                Text(
                  "تتبع رحلتك",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.bold)
                      .copyWith(color: Theme.of(context).primaryColor),
                )
              ],
            ),
          ),
        ));
  }
}

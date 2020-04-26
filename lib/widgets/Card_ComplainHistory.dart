import 'package:flutter/material.dart';
import 'package:clax/models/Complain.dart';
import 'package:clax/models/Trip.dart';
import 'package:intl/intl.dart' as intl;

class ComplainHistoryCard extends StatelessWidget {
  final ComplainModel complain;
  final Trip trip;
  ComplainHistoryCard({this.complain, this.trip});
  @override
  Widget build(BuildContext context) {
    Widget child;
    if (complain.status != "pending")
      child = Icon(Icons.check_circle_outline, color: Colors.green);
    else
      child = Icon(Icons.highlight_off, color: Colors.red);
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          child: Row(children: [
            Container(
              alignment: Alignment.centerRight,
              child: Text(complain.code.toString().substring(0, 5),
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontFamily: 'Product Sans', color: Colors.grey)),
            ),
            Spacer(flex: 1),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                '${trip.line.from} > ${trip.line.to}',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: "Cairo",
                    color: Colors.black87),
              ),
            ),
            Spacer(flex: 5),
            Spacer(flex: 2),
            Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    intl.DateFormat('M/d').format(complain.date),
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontFamily: "Product Sans", color: Colors.grey),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  child: child,
                ),
              ],
            ),
          ]),
        ),
        Divider(
          height: 1,
        ),
      ],
    );
  }
}

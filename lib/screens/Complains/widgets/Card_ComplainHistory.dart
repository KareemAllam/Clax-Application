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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]),
        ),
      ),
      height: 50,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              child: Text(complain.code.toString().substring(0, 5),
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontFamily: 'Product Sans', color: Colors.grey)),
            ),
            SizedBox(width: 16),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                complain.subject,
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: "Cairo",
                    color: Colors.black87),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                intl.DateFormat('M/d').format(complain.date),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(fontFamily: "Product Sans", color: Colors.grey),
              ),
            ),
            SizedBox(width: 16),
            Container(
              alignment: Alignment.centerLeft,
              child: child,
            ),
          ],
        ),
      ]),
    );
  }
}

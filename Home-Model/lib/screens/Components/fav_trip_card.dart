import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class FavTripCard extends StatefulWidget {
  static const routeName = '/fav_trip_card';
  final Map<String, dynamic> trip;
  FavTripCard(this.trip);
  @override
  _FavTripCardState createState() => _FavTripCardState();
}

class _FavTripCardState extends State<FavTripCard> {
  bool checked = false;
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // SizedBox(width: 15),
              Expanded(
                flex: 7,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.075,
                  alignment: Alignment.centerRight,
                  child: Text(
                    widget.trip['_line'],
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                        fontFamily: 'Cairo'),
                  ),
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          intl.DateFormat.EEEE()
                              .add_jm()
                              .format(DateTime.parse(widget.trip['start'])),
                          textDirection: TextDirection.ltr,
                          style: TextStyle(fontFamily: 'Product Sans'),
                        ),
                        Text(
                          '\$${widget.trip['price']}',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black26),
                        ),
                      ],
                    ),
                  ))
            ],
          )),
      Divider(
        height: 1,
      )
    ]);
  }
}

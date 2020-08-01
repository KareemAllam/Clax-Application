// Dart & Other Packages
import 'package:intl/intl.dart' as intl;
// Flutter's Material Components
import 'package:flutter/material.dart';
// Models
import 'package:clax/models/Trip.dart';

class FavTripCard extends StatefulWidget {
  final Trip trip;
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
              Expanded(
                flex: 7,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.075,
                  alignment: Alignment.centerRight,
                  child: Text(
                    widget.trip.lineName,
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
                              .format(widget.trip.date),
                          textDirection: TextDirection.ltr,
                          style: TextStyle(fontFamily: 'Product Sans'),
                        ),
                        Text(
                          '\$${widget.trip.cost}',
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

import 'package:clax/models/trip.dart';
import 'package:flutter/material.dart';
import '../../data.dart';
import 'package:intl/intl.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        ...trips.map((trip) {
          return TripCard(trip);
        }),
      ]),
    );
  }
}

class TripCard extends StatefulWidget {
  final Trip trip;
  TripCard(this.trip);
  @override
  _TripCardState createState() => _TripCardState();
}

class _TripCardState extends State<TripCard> {
  bool checked = false;
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 20,
                height: MediaQuery.of(context).size.height * 0.08,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      checked = !checked;
                    });
                  },
                  child: checked
                      ? Icon(Icons.star_border)
                      : Icon(
                          Icons.star,
                          size: 25,
                          color: Theme.of(context).accentColor,
                        ),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                flex: 7,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.trip.location,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87),
                      ),
                      Text(DateFormat('yyyy-MM-dd').format(widget.trip.date)),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '\$${widget.trip.price}',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Colors.black54),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(
                              Icons.sentiment_satisfied,
                              color: Theme.of(context).accentColor,
                            ),
                            SizedBox(width: 4),
                            Text('%${widget.trip.rate}',
                                style: TextStyle(fontSize: 16)),
                          ],
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

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as special;

class TripCard extends StatelessWidget {
  static const routeName = '/trip_card';
  final Map<String, dynamic> trip;
  final Function changeTrips;
  TripCard(this.trip, this.changeTrips);
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 20,
              height: MediaQuery.of(context).size.height * 0.08,
              child: GestureDetector(
                  onTap: () {
                    changeTrips(trip['_id']);
                  },
                  child: trip['is_favourite']
                      ? Icon(
                          Icons.star,
                          size: 25,
                          color: Theme.of(context).accentColor,
                        )
                      : Icon(Icons.star_border)),
            ),
            SizedBox(width: 15),
            Expanded(
              flex: 7,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      " ${trip['_line']}",
                      style: TextStyle(
                          height: 1.2,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          fontFamily: 'Cairo'),
                    ),
                    Text(
                      special.DateFormat('EEE, M/d').add_jm().format(
                            DateTime.parse(trip['start']),
                          ),
                      textDirection: TextDirection.ltr,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '\$${trip['price']}',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 20),
            trip['rate'] < 20
                ? Icon(
                    Icons.sentiment_dissatisfied,
                    color: Colors.redAccent,
                  )
                : trip['rate'] < 40
                    ? Icon(
                        Icons.sentiment_neutral,
                        color: Colors.amber,
                      )
                    : Icon(
                        Icons.sentiment_very_satisfied,
                        color: Colors.green,
                      ),
          ],
        ),
      ),
      Divider(
        height: 1,
      )
    ]);
  }
}

// trip['rate'] < 20
//                                 ? Icon(
//                                     Icons.sentiment_dissatisfied,
//                                     color: Colors.redAccent,
//                                   )
//                                 : trip['rate'] < 40
//                                     ? Icon(
//                                         Icons.sentiment_neutral,
//                                         color: Colors.amber,
//                                       )
//                                     : Icon(
//                                         Icons.sentiment_very_satisfied,
//                                         color: Colors.green,
//                                       ),

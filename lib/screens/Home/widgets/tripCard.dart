import 'package:clax/models/Trip.dart';
import 'package:clax/providers/Trips.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as special;
import 'package:provider/provider.dart';

class TripCard extends StatelessWidget {
  static const routeName = '/trip_card';
  final Trip trip;
  final int index;
  TripCard(this.trip, this.index);
  final rate = 30;
  Widget build(BuildContext context) {
    IconData rateIcon() {
      switch (trip.rate) {
        case 1:
          return Icons.sentiment_very_dissatisfied;
          break;
        case 2:
          return Icons.sentiment_dissatisfied;
          break;
        case 3:
          return Icons.sentiment_neutral;
          break;
        case 4:
          return Icons.sentiment_satisfied;
          break;
        case 5:
          return Icons.sentiment_very_satisfied;
          break;
        default:
          return Icons.sentiment_neutral;
          break;
      }
    }

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
                    Provider.of<TripsProvider>(context, listen: false)
                        .favTrip(index);
                  },
                  child: trip.favorite
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
                      " ${trip.lineName}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      special.DateFormat('EEE, M/d').add_jm().format(
                            trip.startDate,
                          ),
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(color: Colors.grey),
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
                      '${trip.price} جنيه',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 20),
            Icon(
              rateIcon(),
              color: Colors.redAccent,
            )
          ],
        ),
      ),
      Divider(
        height: 1,
      )
    ]);
  }
}

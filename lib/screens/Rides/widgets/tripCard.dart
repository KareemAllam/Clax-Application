// Dart & Other Packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart' as special;
// Models
import 'package:clax/models/Trip.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';

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
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 24.0,
                    child: Icon(
                      FontAwesomeIcons.route,
                      size: 20.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                              trip.date,
                            ),
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Colors.grey),
                        textDirection: TextDirection.ltr,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Icon(Icons.event_seat, color: Colors.grey[350], size: 20),
                SizedBox(width: 8),
                Text('${trip.seats}', style: TextStyle(color: Colors.grey)),
              ]),
            ),
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.confirmation_number,
                      color: Colors.grey[350], size: 20),
                  SizedBox(width: 8),
                  Text(
                    '${trip.cost}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
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

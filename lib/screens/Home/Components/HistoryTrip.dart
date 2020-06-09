// Flutter's Material Components
import 'package:flutter/material.dart';
// Models
import 'package:clax/models/Trip.dart';
// Widgets
import 'package:clax/widgets/null.dart';
import 'package:clax/screens/Home/widgets/tripCard.dart';

class HistoryTrips extends StatelessWidget {
  final List<Trip> trips;
  HistoryTrips(this.trips);
  @override
  Widget build(BuildContext context) {
    bool empty = true;
    if (trips != null) empty = trips.length == 0;
    return empty
        ? Center(
            child: NullContent(things: "رحلات"),
          )
        : ListView.builder(
            itemBuilder: (context, index) => TripCard(trips[index]),
            itemCount: trips.length,
            shrinkWrap: true,
            controller: ScrollController(),
            physics: AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
          );
  }
}

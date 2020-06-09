// Flutter's Material Components
import 'package:flutter/material.dart';
// Models
import 'package:clax/models/Trip.dart';
// Widgets
import 'package:clax/widgets/null.dart';
import 'package:clax/screens/Home/widgets/favTripCard.dart';

class FavouriteTrips extends StatelessWidget {
  final List<Trip> trips;
  FavouriteTrips(this.trips);
  @override
  Widget build(BuildContext context) {
    bool empty = true;
    if (trips != null) empty = trips.length == 0;

    return empty
        ? Center(
            child: NullContent(things: "رحلات"),
          )
        : ListView.builder(
            itemCount: trips.length,
            itemBuilder: (context, index) {
              return FavTripCard(trips[index]);
            },
          );
  }
}

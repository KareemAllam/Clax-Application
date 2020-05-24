// Dart & Other Packages
import 'dart:convert';
import 'package:clax/widgets/null.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Services
import 'package:clax/services/Backend.dart';
// Components
import 'package:clax/screens/Home/Components/fav_trip_card.dart';
// Widgets
import 'package:clax/widgets/404.dart';

class Favourites extends StatefulWidget {
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  int fetched = 0;
  List trips;

  void fetch() async {
    try {
      Response response = await Api.get('passengers/past-trips/favourite');
      if (response.statusCode == 200)
        setState(() {
          trips = json.decode(response.body)['_favourites'];
          fetched = 1;
        });
      else
        setState(() {
          fetched = 2;
        });
    } catch (_) {
      setState(() {
        fetched = 2;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  Widget build(BuildContext context) {
    return fetched == 0
        ? Center(
            child: SpinKitCircle(
              size: MediaQuery.of(context).size.height * 0.13,
              color: Theme.of(context).primaryColor,
              duration: Duration(milliseconds: 500),
            ),
          )
        : fetched == 1
            ? trips.length > 0
                ? ListView.builder(
                    itemCount: trips.length,
                    itemBuilder: (context, index) {
                      return FavTripCard(trips[index]);
                    },
                  )
                : Center(
                    child: NullContent(things: "رحلات"),
                  )
            : Center(child: FourOFour(press: fetch));
  }
}

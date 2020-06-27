import 'package:clax/screens/Components/fav_trip_card.dart';
import 'package:clax/services/Backend.dart';
import 'package:clax/widgets/404.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';

class Favourites extends StatefulWidget {
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  var fetched = 0;
  List<dynamic> trips;

  void fetch() async {
    await Api.get('past-trips/favourite').then(
      (response) {
        print(response.body);
        setState(() {
          trips = json.decode(response.body);
          fetched = 1;
        });
      },
    ).catchError((onError) {
      setState(() {
        fetched = 2;
      });
      print("err");
    });
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
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
            ? ListView.builder(
                itemCount: trips.length,
                itemBuilder: (context, index) {
                  return FavTripCard(trips[index]);
                },
              )
            : Center(child: FourOFour(press: fetch));
  }
}

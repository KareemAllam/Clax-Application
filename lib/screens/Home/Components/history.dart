// Dart & Other Packages
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Services
import 'package:clax/services/Backend.dart';
// Widgets
import 'package:clax/widgets/404.dart';
import 'package:clax/widgets/trip_card.dart';

class History extends StatefulWidget {
  static const routeName = '/history';
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int fetched = 0;
  List<dynamic> trips;

  void changeTrips(id) {
    int index = trips.indexWhere((trip) => trip['_id'] == id);
    trips[index]['is_favourite'] = !trips[index]['is_favourite'];
    setState(() {
      trips = trips;
    });
  }

  void fetch() async {
    await Api.get('passengers/past-trips/').then((response) {
      setState(() {
        trips = json.decode(response.body);
        fetched = 1;
      });
    }).catchError((onError) {
      setState(() {
        fetched = 2;
      });
      print("err");
    });
  }

  void update() async {
    List<String> tripsIds = [];
    for (int i = 0; i < trips.length; i++) {
      if (trips[i]['is_favourite'] == true) {
        tripsIds.add(trips[i]['_id']);
      }
    }
    Map<String, dynamic> body = {
      'tripsIds': tripsIds,
    };
    await Api.put('passengers/past-trips/favourite/', reqBody: body);
    // if (tripsIds.length != 0) {
    //   await Api.put('passengers/past-trips/favourite/', body);
    // }
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  void dispose() {
    super.dispose();
    update();
  }

  Widget build(BuildContext context) {
    return fetched == 0
        ? Center(
            child:
                SpinKitCircle(size: 60, color: Theme.of(context).primaryColor),
          )
        : fetched == 1
            ? SingleChildScrollView(
                child: Column(children: [
                ...trips.map((trip) {
                  return TripCard(trip, changeTrips);
                }),
              ]))
            : Center(child: FourOFour(press: fetch));
  }
}

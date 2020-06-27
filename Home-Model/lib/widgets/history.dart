import 'package:clax/services/Backend.dart';
import 'package:clax/widgets/trip_card.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '404.dart';

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
    // print(trips[index]['is_favourite']);
    trips[index]['is_favourite'] = !trips[index]['is_favourite'];
    setState(() {
      trips = trips;
    });
    // print(trips[index]['is_favourite']);
  }

  void fetch() async {
    await Api.get('past-trips/').then((response) {
      print(response.body);
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
// Map<String, String> body = {
//       '_passenger': '5e53f68e97aeea0dfcde0ea6',
//       '_trip': selectedTrip.sId,
//       'text': description.text
//     };

    List<String> tripsIds = [];
    for (int i = 0; i < trips.length; i++) {
      // print(trips[i]['is_favourite']);
      if (trips[i]['is_favourite'] == true) {
        tripsIds.add(trips[i]['_id']);
      }
    }
    Map<String, dynamic> body = {
      'tripsIds': tripsIds,
    };
    if (tripsIds.length != 0) {
      await Api.put('past-trips/favourite/', body).then((response) {
        print("Successfully Update");
      }).catchError((onError) {
        print("Error Occured...");
      });
    }

    tripsIds.clear();

    for (int i = 0; i < trips.length; i++) {
      // print(trips[i]['is_favourite']);
      if (trips[i]['is_favourite'] == false) {
        tripsIds.add(trips[i]['_id']);
      }
    }

    body = {
      'tripsIds': tripsIds,
    };
    if (tripsIds.length != 0) {
      await Api.put('past-trips/favourite/delete', body).then((response) {
        print("Successfully Deleted");
      }).catchError((onError) {
        print("Error Occured...");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  void dispose() {
    super.dispose();
    print('disposing');
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

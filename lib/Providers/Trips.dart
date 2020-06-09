// Dart & Other Packages
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Models
import 'package:clax/models/Trip.dart';
// Service
import 'package:clax/services/Backend.dart';

class TripsProvider extends ChangeNotifier {
  // Last Trips
  List<Trip> trips = [];
  List<Trip> favs = [];

  // Provider Constructor
  TripsProvider() {
    initialize();
  }

  // Async Constructor
  Future initialize() async {
    // Fetch Data from Cache
    await cacheData();
    // Fetch Data from Server
    // await serverData();
  }

  Future cacheData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // Get Cached Past Trips
    trips = _prefs.getString("pastTrips") != null
        ? json
            .decode(_prefs.getString("pastTrips"))
            .forEach((trip) => trips.add(Trip.fromJson(trip)))
        : [];
    notifyListeners();
  }

  Future<bool> serverData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    Response response = await Api.get('passengers/past-trips/');
    if (response.statusCode == 200) {
      List<Trip> pastTrips = [];
      List _ = json.decode(response.body);
      if (_ == []) _ = [];
      if (_.length > 0) {
        _.map((trip) {
          Trip _trip = Trip.fromJson(trip);
          pastTrips.add(_trip);
        }).toList();
        trips = pastTrips;
        _prefs.setString('pastTrips', json.encode(trips));
        notifyListeners();
      }
      return true;
    }
    return false;
  }

  Future addTrip(Trip trip) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (trips == null) trips = [];
    trips.add(trip);
    _prefs.setString('pastTrips', json.encode(trips));
    notifyListeners();
  }
}

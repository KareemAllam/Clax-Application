// Dart & Other Packages
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Models
import 'package:clax/models/Station.dart';
import 'package:clax/models/Trip.dart';
// Service
import 'package:clax/services/Backend.dart';

class TripsProvider extends ChangeNotifier {
  // Last Trips
  List<Trip> _trips;

  // Current Available Stations
  List<Station> _stations;
  // Provider Constructor
  TripsProvider() {
    initialize();
  }

  // Async Constructor
  Future initialize() async {
    // Fetch Data from Cache
    await cacheData();
    // Fetch Data from Server
    await serverData();
  }

  Future cacheData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // Get Cached Past Trips
    _trips = _prefs.getString("trips") != null
        ? json
            .decode(_prefs.getString("trips"))
            .forEach((trip) => _trips.add(Trip.fromJson(trip)))
        : [];

    // Get Cached Stations
    _stations = _prefs.getString("appMap") != null
        ? json
            .decode(_prefs.getString("appMap"))
            .forEach((station) => _stations.add(Station.fromJson(station)))
        : [];

    notifyListeners();
  }

  Future<bool> serverData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      Response trips = await Api.get('passengers/past-trips/');
      if (trips.statusCode == 200) {
        _trips = List<Trip>.from((json
            .decode(trips.body)['_pastTrips']
            .map((trip) => Trip.fromJson(trip))).toList());
        _prefs.setString('trips', json.encode(_trips));
        notifyListeners();
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  List<Trip> get trips => _trips;
}

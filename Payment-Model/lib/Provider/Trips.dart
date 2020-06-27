import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/Trip.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/Backend.dart';
import 'package:http/http.dart';

class Trips extends ChangeNotifier {
  List<Trip> _trips = [];
  Trips() {
    initialize();
  }

  void initialize() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // Get Cached Data
    _trips = _prefs.getString("trips") != null
        ? json
            .decode(_prefs.getString("trips"))
            .forEach((trip) => _trips.add(Trip.fromJson(trip)))
        : [];
    notifyListeners();

    // Fetch Data from Server
    await fetchData();
  }

  Future<bool> fetchData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      Response trips = await Api.get('user');
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

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/Complain.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/Backend.dart';
import 'package:http/http.dart';

class Complains extends ChangeNotifier {
  List<Complain> _complains = [];
  Complains() {
    initialize();
  }

  void initialize() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // Get Cached Data
    if (_prefs.getString("complains") != null) {
      json
          .decode(_prefs.getString("complains"))
          .forEach((complain) => _complains.add(Complain.fromJson(complain)));
      notifyListeners();
    }
    fetchData();
  }

  // Fetch Data from Server
  Future<bool> fetchData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      Response response = await Api.get('user/mycomplaint');
      if (response.statusCode == 200) {
        _complains = List<Complain>.from((json
            .decode(response.body)
            .map((trip) => Complain.fromJson(trip))).toList());
        _prefs.setString("complains", json.encode(_complains));
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }

  Future<bool> add(body) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      Response result = await Api.post("user/complaint", body);
      if (result.statusCode == 200) {
        print(result.body);
        Complain complain = Complain.fromJson(json.decode(result.body));
        _complains.add(complain);
        _prefs.setString("complains", json.encode(_complains));
        notifyListeners();
        return true;
      } else
        return false;
    } catch (e) {
      return false;
    }
  }

  List<Complain> get complains => _complains;
}

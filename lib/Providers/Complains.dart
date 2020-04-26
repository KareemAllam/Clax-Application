import 'package:flutter/material.dart';
import 'package:clax/models/Complain.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/Backend.dart';
import 'package:http/http.dart';

class ComplainsProvider extends ChangeNotifier {
  List<ComplainModel> _complains = [];
  ComplainsProvider() {
    initialize();
  }

  void initialize() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // Get Cached Data
    if (_prefs.getString("complains") != null) {
      json.decode(_prefs.getString("complains")).forEach(
          (complain) => _complains.add(ComplainModel.fromJson(complain)));
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
        _complains = List<ComplainModel>.from((json
            .decode(response.body)
            .map((trip) => ComplainModel.fromJson(trip))).toList());
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
        ComplainModel complain =
            ComplainModel.fromJson(json.decode(result.body));
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

  List<ComplainModel> get complains => _complains;
}

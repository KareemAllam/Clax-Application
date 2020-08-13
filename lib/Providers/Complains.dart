// Dart & Other Pacakges
import 'dart:convert';
import 'package:clax/models/Error.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Flutter Foundation
import 'package:flutter/foundation.dart';
// Models
import 'package:clax/models/Complain.dart';
// Services
import 'package:clax/services/Backend.dart';

class ComplainsProvider extends ChangeNotifier {
  List<ComplainModel> _complains = [];
  ComplainsProvider() {
    init();
  }
  void init() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // Get Cached Data
    if (_prefs.getString("complains") != null) {
      json.decode(_prefs.getString("complains")).forEach(
          (complain) => _complains.add(ComplainModel.fromJson(complain)));
      notifyListeners();
    }
    serverData();
  }

  // Fetch Data from Server
  Future<ServerResponse> serverData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    Response response = await Api.get('passengers/complaints/all');
    if (response.statusCode == 200) {
      _complains = List<ComplainModel>.from((json
          .decode(response.body)
          .map((trip) => ComplainModel.fromJson(trip))).toList());
      _prefs.setString("complains", json.encode(_complains));
      notifyListeners();
      return ServerResponse(status: true);
    } else {
      return ServerResponse(
          status: false, message: "تأكد من اتصالك بالانترنت و حاول مره اخرى.");
    }
  }

  Future<ServerResponse> add(requestBody, String lineName) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    Response result = await Api.post("passengers/complaints/add", requestBody,
        stringDynamic: true);
    if (result.statusCode == 200) {
      Map<String, dynamic> body = json.decode(result.body);
      ComplainModel _complaint = ComplainModel.fromJson(body);
      if (body['_trip'] != null) {
        _complaint.lineName = lineName;
      }
      _complains.add(_complaint);
      _prefs.setString("complains", json.encode(_complains));
      notifyListeners();
      return ServerResponse(status: true);
    } else
      return ServerResponse(
          status: false,
          message: "تعذر الوصول للخادم. حاول مره اخرى في وقت لاحق");
  }

  List<ComplainModel> get complains => _complains;
}

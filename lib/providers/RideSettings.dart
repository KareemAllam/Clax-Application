// Dart & Other Pacakges
import 'dart:convert';
// import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// Flutter Material Componenets
import 'package:flutter/material.dart';
// Models
import 'package:clax/models/Car.dart';
import 'package:clax/models/Line.dart';
// import 'package:clax/models/Station.dart';
// Services
// import 'package:clax/services/Backend.dart';
// import 'package:clax/services/RealtimeDB.dart';

class TripSettingsProvider extends ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey;
  // Ride Info
  List<LineModel> driverLines = [];
  LineModel currnetLine;
  List<Car> driverCars;
  Car currentCar;
  int currnetSeats = 5;
  bool working = false;
  // Synchronous Constructor
  TripSettingsProvider() {
    init();
  }

  // ASynchronous Constructor
  Future init() async {
    // SharedPreferences _prefs = await SharedPreferences.getInstance();
    // Get User's Saved Lines
    // if (_prefs.getString("driverLines") != null)
    //   (json.decode(_prefs.getString("driverLines")) as List).forEach((element) {
    //     driverLines.add(LineModel.fromJson(element));
    //   });
    // if (driverLines == [] || driverLines == null)
    driverLines = staticLines;
    // Get User's Current staticData
    // if (_prefs.getString("currnetLine") != null)
    //   currnetLine =
    //       LineModel.fromJson(json.decode(_prefs.getString("currnetLine")));
    currnetLine = driverLines[0];
    // Get User's Saved Cars
    // if (_prefs.getString("driverCars") != null)
    //   (json.decode(_prefs.getString("driverCars")) as List).forEach((element) {
    //     driverCars.add(Car.fromJson(element));
    //   });
    // if (driverCars == [] || driverCars == null)
    driverCars = staticCars;
    // Get User's Current Car
    // if (_prefs.getString("currentCar") != null)
    //   currentCar = Car.fromJson(json.decode(_prefs.getString("currentCar")));
    currentCar = driverCars[0];
    notifyListeners();
  }

  Future changeCar(Car car) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString("currentCar", json.encode(car.toJson()));
    currentCar = car;
    notifyListeners();
  }

  Future changeLine(LineModel line) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString("currentCar", json.encode(line.toJson()));
    currnetLine = line;
    notifyListeners();
  }
}

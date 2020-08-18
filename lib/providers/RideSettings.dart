// Dart & Other Pacakges
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Flutter Material Componenets
import 'package:flutter/material.dart';
// Models
import 'package:clax/models/Car.dart';
import 'package:clax/models/Line.dart';
// Services
import 'package:clax/services/Backend.dart';

class TripSettingsProvider extends ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey;
  // Ride Info
  List<LineModel> lines = [];
  LineModel currnetLine;
  List<Car> driverCars;
  Car currentCar;
  int currnetSeats = 5;
  bool canWork = false;
  bool onGoingTrip = false;
  // Synchronous Constructor
  TripSettingsProvider() {
    init();
  }

  // ASynchronous Constructor
  Future init() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // onGoingTrip = _prefs.getBool("onGoingTrip");

    // Get User's Saved Lines
    if (_prefs.getString("lines") != null)
      lines = _prefs.getString("lines") == null
          ? []
          : List<LineModel>.from(
              json
                  .decode(_prefs.getString("lines"))
                  .map((card) => LineModel.fromJson(card)),
            ).toList();
    // Get User's Saved Cars
    // if (_prefs.getString("driverCars") != null)
    //   (json.decode(_prefs.getString("driverCars")) as List).forEach((element) {
    //     driverCars.add(Car.fromJson(element));
    //   });
    // if (driverCars == [] || driverCars == null)
    driverCars = staticCars;

    // Check Current Application State

    // Get User's Current staticData
    if (lines.length == 0) await fetchDataOnline();
    currnetLine = lines[0];

    // Get User's Current Car
    // if (_prefs.getString("currentCar") != null)
    //   currentCar = Car.fromJson(json.decode(_prefs.getString("currentCar")));
    currentCar = driverCars[0];
    notifyListeners();
  }

  Future fetchDataOnline() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response response = await Api.get('passengers/pairing/line');
    if (response.statusCode == 200) {
      lines = List<LineModel>.from(
        json.decode(response.body).map((line) => LineModel.fromJson(line)),
      ).toList();
      prefs.setString('lines', response.body);
      notifyListeners();
    }
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

  void canWorkState(bool state) {
    canWork = state;
    notifyListeners();
  }

  void onGoingTripState(bool state) async {
    if (state)
      onGoingTrip = state;
    else
      onGoingTrip = !onGoingTrip;
    notifyListeners();
    // _prefs.setBool("onGoingTrip", onGoingTrip);
  }
}

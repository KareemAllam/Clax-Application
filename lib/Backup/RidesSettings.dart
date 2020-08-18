// Dart & Other Pacakges
import 'dart:convert';
import 'package:clax/services/RealtimeDB.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Flutter Material Componenets
import 'package:flutter/material.dart';
// Models
import 'package:clax/models/Car.dart';
import 'package:clax/models/Line.dart';
// Services
import 'package:clax/services/Backend.dart';
// Widgets
import 'package:clax/widgets/Alerts.dart';

class TripSettingsProvider extends ChangeNotifier {
  GlobalKey<ScaffoldState> scaffoldKey;
  // Ride Info
  List<LineModel> lines = [];
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
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // Get User's Saved Lines
    lines = _prefs.getString("lines") == null
        ? []
        : List<LineModel>.from(
            json
                .decode(_prefs.getString("lines"))
                .map((card) => LineModel.fromJson(card)),
          ).toList();
    if (lines.length == 0) fetchDataOnline();
    currnetLine = lines[0];

    // Get User's Saved Cars
    // if (_prefs.getString("driverCars") != null)
    //   (json.decode(_prefs.getString("driverCars")) as List).forEach((element) {
    //     driverCars.add(Car.fromJson(element));
    //   });
    // if (driverCars == [] || driverCars == null)
    driverCars = staticCars;
    currentCar = staticCars[0];
    notifyListeners();
    // Check Current Application State
    // checkCurrentState();
  }

  void fetchDataOnline() async {
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

  void checkCurrentState() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // Cache Working Data
    working = _prefs.getBool("working") ?? false;
    if (_prefs.getString("currentLine") != null) {
      currnetLine =
          LineModel.fromJson(json.decode(_prefs.getString("currentLine")));
    }
    notifyListeners();
    // Check App State
    if (working == true) {
      DateTime lastWorking = DateTime.parse(_prefs.getString("lastWorking"));
      if (lastWorking.difference(DateTime.now()).inMinutes < 3) {
        bool continueRide = await keepWorkingAlert(scaffoldKey.currentContext,
            lineName: currnetLine.lineName());
        // Driver want to continue his ride
        if (continueRide) {
          // Trackback requestId
          String requestId = _prefs.getString("requestId");
          // Start Listening to Request
          Map<String, dynamic> requestValues =
              await RealtimeDB().readOnce('clax-lines/$requestId');
          if (requestValues == null) {
            oneButtonAlertDialoge(scaffoldKey.currentContext,
                title: "حد مشكلة في استكمال الرحلة", description: "asd");
          }
          // If no data, trip has ended
          // Navigate to Map
        }
      }
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
    _prefs.setString("currentLine", json.encode(line.toJson()));
    currnetLine = line;
    notifyListeners();
  }

  void changeWorkingState({bool state, LineModel line}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    working = state;
    _prefs.setBool("working", state);

    if (state) {
      currnetLine = line;
      _prefs.setString("lastWorking", DateTime.now().toString());
      _prefs.setString("currentLine", json.encode(line));
    }
  }
}

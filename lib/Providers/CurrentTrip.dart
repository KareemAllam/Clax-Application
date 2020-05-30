import 'dart:convert';

import 'package:clax/services/Backend.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentTripProvider extends ChangeNotifier {
  // Setting App to Trip State so User can't make another tirp
  String driverId;
  double price;
  bool busy;
  Map<String, dynamic> currentDriverInfo;
  Map<String, dynamic> currentTripInfo;
  CurrentTripProvider() {
    init();
  }
  void init() async {
    busy = false;
    await cachedData();
  }

  Future cachedData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // If a trip is currentةly available
    if (_prefs.getString("driverInfo") != null)
      currentDriverInfo = json.decode(_prefs.getString("driverInfo"));
    else
      currentDriverInfo = null;
    currentDriverInfo == null ? busy = false : busy = true;
    notifyListeners();
  }

  void setTripInfo(String _driverId) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString("driverId", _driverId);
    driverId = _driverId;
    notifyListeners();
    Response driverInfoEncoded =
        await Api.post('pairing/driver', {"driverid": _driverId});
    if (driverInfoEncoded.statusCode == 200) {
      _prefs.setString('driverInfo', driverInfoEncoded.body);
      currentDriverInfo =
          new Map<String, dynamic>.from(json.decode(driverInfoEncoded.body));
      notifyListeners();
    }
  }

  Future clearTripInfo() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    currentDriverInfo = null;
    driverId = null;
    _prefs.remove("driverInfo");
    notifyListeners();
  }

  void searchingDriverState(double _price) {
    price = _price;
    busy = true;
    notifyListeners();
  }

  void idleState() {
    price = 0;
    busy = false;
    notifyListeners();
  }
}

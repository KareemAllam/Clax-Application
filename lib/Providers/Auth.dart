import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  String _auth = "User Not Authenticated";
  SharedPreferences _prefs;
  // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Auth() {
    getSharedPrefrence();
  }

  Future<String> getSharedPrefrence() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _auth = _prefs.getString("loginToken");
      notifyListeners();
      return _auth;
    } catch (_) {
      return null;
    }
  }

  bool isUserAuthenticated() {
    return _auth == "User Not Authenticated" ? false : true;
  }

  String getUser() {
    return _auth;
  }

  bool logIn(String token) {
    try {
      _prefs.setString("loginToken", token);
      _auth = token;
      notifyListeners();
      return true;
    } catch (_) {
      _prefs.remove("loginToken");
      _auth = "User Not Authenticated";
      notifyListeners();
      return false;
    }
  }

  bool logOut() {
    String originalToken = _auth;
    try {
      _prefs.remove("loginToken");
      _auth = "User Not Authenticated";
      notifyListeners();
      return true;
    } catch (_) {
      _prefs.setString("loginToken", originalToken);
      _auth = originalToken;
      notifyListeners();
      return true;
    }
  }
}

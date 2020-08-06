// Dart & Other Pacakges
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// Flutter Foundation
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  String _auth = "";
  SharedPreferences _prefs;
  String _firebaseToken;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  BuildContext outerContext;

  AuthProvider() {
    checkAuthentication();
    firebaseConfig();
  }

  Future firebaseConfig() async {
    _firebaseToken = await _firebaseMessaging.getToken();
    // print(_firebaseToken);
  }

  Future<String> checkAuthentication() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _auth = _prefs.getString("loginToken");
      // notifyListeners();
      return _auth;
    } catch (_) {
      return null;
    }
  }

  bool isUserAuthenticated() {
    return _auth == "" ? false : true;
  }

  String getUser() {
    return _auth;
  }

  bool logIn(String token) {
    try {
      _prefs.setString("loginToken", token);
      _auth = token;
      return true;
    } catch (_) {
      _prefs.remove("loginToken");
      _auth = "";
      return false;
    }
  }

  Future<bool> logOut() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.clear();
    String originalToken = _auth;
    try {
      _auth = "";
      notifyListeners();
      return true;
    } catch (_) {
      _prefs.setString("loginToken", originalToken);
      _auth = originalToken;
      notifyListeners();
      return false;
    }
  }

  String get fbToken => _firebaseToken;
}

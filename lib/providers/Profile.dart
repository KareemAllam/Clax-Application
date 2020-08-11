// Dart & Other Pacakges
import 'dart:convert';
import 'package:clax/models/Error.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Flutter Foundation
import 'package:flutter/foundation.dart';
// Models
import 'package:clax/models/Profile.dart';
// Services
import 'package:clax/services/Backend.dart';

class ProfilesProvider with ChangeNotifier {
  // Initial Data
  ProfileModel _profile = ProfileModel();
  String id = "5ee2490b9b6b5f4018c75f82";
  // Provider's Useless Constructor
  ProfilesProvider() {
    init();
  }
  // Async Constructor
  Future init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('profile') != null) {
      _profile = ProfileModel.fromJson(json.decode(prefs.getString('profile')));
      notifyListeners();
    }
    try {
      Response account = await Api.get('drivers/settings/me');
      if (account.statusCode == 200) {
        Map<String, dynamic> profile = json.decode(account.body);
        _profile = ProfileModel.fromJson(profile);
        prefs.setString('profile', account.body);
        notifyListeners();
      }
    } catch (_) {}
  }

  Future<ServerResponse> updateProfile(Map<String, dynamic> changes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> originalAccount = _profile.toJson();
    Response account = await Api.put('drivers/settings/me', reqBody: changes);
    if (account.statusCode == 200) {
      changes.forEach((key, value) => originalAccount["$key"] = value);
      _profile = ProfileModel.fromJson(originalAccount);
      prefs.setString('profile', json.encode(originalAccount));
      notifyListeners();
      return ServerResponse(status: true);
    } else {
      _profile = ProfileModel.fromJson(originalAccount);
      notifyListeners();
      return ServerResponse(status: false, message: "تعذر الوصول للخادم");
    }
  }

  Future<bool> verifyPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response result = await Api.put("drivers/settings/phone-verification");
    if (result.statusCode == 200) {
      _profile.phoneVerified = true;
      String updatedProfile = json.encode(_profile.toJson());
      prefs.setString('profile', updatedProfile);
      return true;
    } else
      return false;
  }

  bool get phoneVerified => _profile.phoneVerified;
  ProfileModel get profile => _profile;
}

/// Seats
/// Current Car
/// Current Line
/// Driver's Info

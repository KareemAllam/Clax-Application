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
  ProfileModel profile = ProfileModel();

  // Provider's Useless Constructor
  ProfilesProvider() {
    init();
  }

  // Async Constructor
  Future init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('profile') != null) {
      profile = ProfileModel.fromJson(json.decode(prefs.getString('profile')));
      notifyListeners();
    }
    try {
      Response account = await Api.get('passengers/settings/me');
      if (account.statusCode == 200) {
        Map<String, dynamic> _profile = json.decode(account.body);
        profile = ProfileModel.fromJson(_profile);
        prefs.setString('profile', account.body);
        notifyListeners();
      }
    } catch (_) {}
  }

  Future<ServerResponse> updateProfile(Map<String, dynamic> changes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> originalAccount = profile.toJson();
    Response response =
        await Api.put('passengers/settings/me', reqBody: changes);
    if (response.statusCode == 200) {
      changes.forEach((key, value) => originalAccount["$key"] = value);
      profile = ProfileModel.fromJson(originalAccount);
      prefs.setString('profile', json.encode(profile));
      notifyListeners();
      return ServerResponse(status: true);
    } else if (response.statusCode == 499) {
      profile = ProfileModel.fromJson(originalAccount);
      notifyListeners();
      return ServerResponse(status: false, message: response.body);
    } else {
      profile = ProfileModel.fromJson(originalAccount);
      notifyListeners();
      return ServerResponse(
          status: false,
          message: "تعذر الوصول للخادم. حاول مرة اخرى في وقت لاحق");
    }
  }

  Future<bool> verifyPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response result = await Api.put("passengers/settings/phone-verification");
    if (result.statusCode == 200) {
      profile.phoneVerified = true;
      String updatedProfile = json.encode(profile.toJson());
      prefs.setString('profile', updatedProfile);
      return true;
    } else
      return false;
  }

  bool get phoneVerified => profile.phoneVerified;
}

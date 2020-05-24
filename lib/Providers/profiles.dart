import 'package:flutter/material.dart';
import 'package:clax/models/profile.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:clax/services/Backend.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilesProvider with ChangeNotifier {
  // Initial Data
  ProfileModel _profile = ProfileModel();

  // Provider's Useless Constructor
  ProfilesProvider() {
    init();
  }
  // Async Constructor
  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('profile') != null) {
      _profile = ProfileModel.fromJson(json.decode(prefs.getString('profile')));
      notifyListeners();
    }
    try {
      Response account = await Api.get('passengers/settings/me');
      if (account.statusCode == 200) {
        Map<String, dynamic> profile = json.decode(account.body);
        _profile = ProfileModel.fromJson(profile);
        prefs.setString('profile', account.body);
        notifyListeners();
      }
    } catch (_) {}
  }

  Future<String> updateProfile(
      Map<String, dynamic> changes, ProfileModel editiedProfile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(editiedProfile.name.first);
    ProfileModel originalAccount = _profile;
    try {
      Response account =
          await Api.put('passengers/settings/me', reqBody: changes);
      if (account.statusCode == 200) {
        _profile = editiedProfile;
        prefs.setString('profile', json.encode(editiedProfile));
        notifyListeners();
        return 'success';
      } else {
        _profile = originalAccount;
        notifyListeners();
        return "error";
      }
    } catch (_) {
      _profile = originalAccount;
      notifyListeners();
      return "error";
    }
  }

  Future<bool> verifyPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response result = await Api.put("passengers/settings/phone-verification");
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

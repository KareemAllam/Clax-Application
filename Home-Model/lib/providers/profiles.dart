import 'package:flutter/material.dart';
import 'package:clax/models/profile.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:clax/services/Backend.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profiles with ChangeNotifier {
  // Initial Data
  Profile _profile = Profile(
      name: Name(first: "Hager", last: "Alaa El-Din"),
      phone: '+201090556127',
      mailVerified: true,
      phoneVerified: true,
      mail: 'h.alaaeldeen97@gmail.com',
      avatarIndex: 2,
      passLength: 8,
      pass: '');

  // Provider Constructor
  Profiles() {
    init();
  }

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('profile') != null) {
      print("fetching Data");
      _profile = Profile.fromJson(json.decode(prefs.getString('profile')));
      notifyListeners();
    }
    try {
      Response account = await Api.get('passengers/settings/me');
      if (account.statusCode == 200) {
        var profile = json.decode(account.body);
        _profile = Profile.fromJson(profile);
        notifyListeners();
      }
    } catch (_) {}
  }

  Future<String> updateProfile(
      Map<String, dynamic> changes, Profile editiedProfile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Profile originalAccount = _profile;
    _profile = editiedProfile;
    notifyListeners();
    try {
      Response account = await Api.put('passengers/settings/me', changes);
      if (account.statusCode == 200) {
        prefs.setString('profile', json.encode(editiedProfile));
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
    _profile.phoneVerified = true;
    Response result =
        await Api.post("passengers/settings/phone-verification", {});
    if (result.statusCode == 200) {
      return true;
    } else
      return false;
  }

  Profile get profile => _profile;
}

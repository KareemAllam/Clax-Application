import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/Bill.dart';
import 'package:flutter_complete_guide/services/Backend.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Payments extends ChangeNotifier {
  List<Bill> _bills = [];
  Payments() {
    init();
  }
  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('bills') != null) {
      _bills = prefs.getString('bills') ?? [];
      notifyListeners();
    }
    fetchData();
  }

  Future<bool> fetchData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      Response response = await Api.get('payment');
      if (response.statusCode == 200) {
        List result = json.decode(response.body);
        if (result.length > 0) {
          _bills = List<Bill>.from((json
              .decode(response.body)
              .map((payment) => Bill.fromJson(payment))).toList());
          _prefs.setString("bills", json.encode(_bills));
        } else {
          _bills = [];
          _prefs.setString("bills", json.encode(_bills));
        }
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }

  void add(String billJson) async {
    Bill bill = Bill.fromJson(json.decode(billJson));
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _bills.add(bill);
    _prefs.setString("bills", json.encode(_bills));
    notifyListeners();
  }

  List<Bill> get bills => _bills;
}

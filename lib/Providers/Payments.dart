import 'package:flutter/material.dart';
import 'package:clax/models/Bill.dart';
import 'package:clax/services/Backend.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PaymentsProvider extends ChangeNotifier {
  List<BillModel> _bills = [];
  PaymentsProvider() {
    init();
  }

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('bills') != null) {
      _bills =
          List<BillModel>.from(json.decode(prefs.getString('bills')) as List) ??
              [];
      notifyListeners();
    }
    fetchData();
  }

  Future<bool> fetchData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      Response response = await Api.get('payments/manage-financials');
      if (response.statusCode == 200) {
        List result = json.decode(response.body);
        if (result.length > 0) {
          _bills = List<BillModel>.from((json
              .decode(response.body)
              .map((payment) => BillModel.fromJson(payment))).toList());
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
    BillModel bill = BillModel.fromJson(json.decode(billJson));
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _bills.add(bill);
    _prefs.setString("bills", json.encode(_bills));
    notifyListeners();
  }

  List<BillModel> get bills => _bills;
}

// Dart & Other Pacakges
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Flutter Foundation
import 'package:flutter/foundation.dart';
// Models
import 'package:clax/models/Bill.dart';
import 'package:clax/models/Error.dart';
// Services
import 'package:clax/services/Backend.dart';

class PaymentProvider extends ChangeNotifier {
  double balance = 0.0;
  List<BillModel> bills = [];

  PaymentProvider() {
    init();
  }

  // Async Constructor
  Future init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve Balance from cache

    balance = prefs.getDouble('balance') ?? 0.0;
    // Retrieve PaymentLog from cache
    if (prefs.getString('bills') != null) {
      bills = List<BillModel>.from(json
              .decode(prefs.getString('bills'))
              .map((bill) => BillModel.fromJson(bill))).toList() ??
          [];
      try {
        bills = List<BillModel>.from(
            bills.getRange(bills.length - 1 - 7, bills.length - 1));
      } catch (err) {}
    }
    notifyListeners();
    await serverData();
  }

  // Fetch Updated Data from Server.
  Future<ServerResponse> serverData() async {
    // Cache Management
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retreive PaymentLog from Server
    Response finance = await Api.get('drivers/balanceHistory');
    if (finance.statusCode == 200) {
      Map result = json.decode(finance.body);
      // Updating Balance
      balance = result["balance"].toDouble();
      // Bills
      List _bills = result['_tours'];
      if (_bills.length > 0) {
        // Assigning Result to statue
        bills = List<BillModel>.from(
            (_bills.map((payment) => BillModel.fromJson(payment))).toList());
        try {
          bills = List<BillModel>.from(
              bills.getRange(bills.length - 1 - 7, bills.length - 1));
        } catch (err) {}
      } else {
        // Assigning Result to statue
        bills = [];
      }
      // Saving Result in Cahce
      prefs.setDouble("balance", balance);
      prefs.setString("bills", json.encode(bills));
      notifyListeners();
      return ServerResponse(status: true);
    } else if (finance.statusCode == 408)
      return ServerResponse(status: false, message: "تعذر الوصول للخادم");
    else
      return ServerResponse(status: false, message: "حدث خطأ ما.");
  }

  // Start a new bill
  Future startNewTrip(BillModel tripBill) async {
    bills.add(tripBill);
    notifyListeners();
  }

  // End current bill
  Future endTrip() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // Saving Last Trip's Payment
    balance += bills[bills.length - 1].seats * bills[bills.length - 1].cost;
    _prefs.setDouble("balance", balance);
    _prefs.setString("bills", json.encode(bills));
  }

  // Add a passneger to the current trip
  void updateCurrentTrip(int seats) {
    bills[bills.length - 1].seats += seats;
    notifyListeners();
  }
}

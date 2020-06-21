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
    }
    notifyListeners();
    await serverData();
  }

  // Fetch Updated Data from Server.
  Future<ServerResponse> serverData() async {
    // Cache Management
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retreive PaymentLog from Server
    Response finance = await Api.get('passengers/payments/manage-financials');
    if (finance.statusCode == 200) {
      List bills = json.decode(finance.body);
      if (bills.length > 0) {
        // Assigning Result to statue
        bills = List<BillModel>.from((json
            .decode(finance.body)
            .map((payment) => BillModel.fromJson(payment))).toList());
        // Saving Result in Cahce
        prefs.setString("bills", json.encode(bills));
      } else {
        // Assigning Result to statue
        bills = [];
        // Saving Result in Cahce
        prefs.setString("bills", json.encode(bills));
        notifyListeners();
      }
      return ServerResponse(status: true);
    } else if (finance.statusCode == 408)
      return ServerResponse(status: false, message: "تعذر الوصول للخادم");
    else
      return ServerResponse(status: false, message: "حدث خطأ ما.");
  }

  // Add a bill
  Future startNewTrip(BillModel tripBill) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // Saving Last Trip's Payment

    if (bills.length != 0) {
      balance +=
          bills[bills.length - 1].totalSeats * bills[bills.length - 1].ppc;
      _prefs.setDouble("balance", balance);
      _prefs.setString("bills", json.encode(bills));
    }
    bills.add(tripBill);
    notifyListeners();
  }

  void updateCurrentTrip(int seats) {
    bills[bills.length - 1].totalSeats += seats;
    notifyListeners();
  }
}

// Dart & Other Pacakges
import 'dart:convert';
import 'package:clax/models/Error.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Flutter Foundation
import 'package:flutter/foundation.dart';
// Models
import 'package:clax/models/Transaction.dart';
// Services
import 'package:clax/services/Backend.dart';

class TransactionsProvider extends ChangeNotifier {
  List<TransactionModel> _transactions = [];
  TransactionsProvider() {
    init();
  }

  // Import Local Data
  Future init() async {
    // Cheeck if Cache is empty
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString("transactions") != null) {
      json.decode(_prefs.getString("transactions")).forEach((transaction) =>
          _transactions.add(TransactionModel.fromJson(transaction)));
      notifyListeners();
    }
    getRequests();
  }

  /// Get Transfer Requests
  Future<bool> getRequests() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      Response response =
          await Api.get('passengers/payments/loaning/fetch-requests');
      if (response.statusCode == 200) {
        _transactions = List<TransactionModel>.from((json
                .decode(response.body)
                .map((transaction) => TransactionModel.fromJson(transaction)))
            .toList());
        _prefs.setString("transactions", json.encode(_transactions));
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
  }

  /// Cancel a Transfer Request
  Future<bool> cancelARequest(String transactionId, type) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    TransactionModel transaction = (_transactions
        .where((element) => element.id == transactionId)
        .toList())[0];
    _transactions.remove(transaction);
    Map<String, String> body = {"transactionId": transactionId, "type": type};
    try {
      Response result =
          await Api.post("passengers/payments/loaning/reject-request", body);
      if (result.statusCode == 200) {
        _prefs.setString("transactions", json.encode(_transactions));
        notifyListeners();
        return true;
      } else {
        _transactions.add(transaction);
        notifyListeners();
        return false;
      }
    } catch (_) {
      _transactions.add(transaction);
      notifyListeners();
      return false;
    }
  }

  /// Make a Transfer Request
  Future<ServerResponse> makeARequest(body) async {
    Response response =
        await Api.post('passengers/payments/loaning/request-loan', body);
    if (response.statusCode == 408)
      return ServerResponse(
          status: false,
          message:
              "تعذر الوصول للإنترنت. تأكد من اتصالك بالإنترنت و حاول مره اخرى.");
    else if (response.statusCode == 400)
      return ServerResponse(
          status: false, message: "عذرا، هذا المستخدم غير موجود لدينا");
    else if (response.statusCode == 204)
      return ServerResponse(
          status: false, message: "عذرا، هذا المستخدم ليس لديه رصيد كافي");
    else
      return ServerResponse(status: true);
  }

  /// Accept a Transfer Request
  Future<String> acceptARequest(String transactionId) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    TransactionModel transaction = (_transactions
        .where((element) => element.id == transactionId)
        .toList())[0];
    _transactions.remove(transaction);
    notifyListeners();
    Map<String, String> body = {
      "transactionId": transactionId,
      "loanerNamed": "Kareem Allam"
    };
    try {
      Response result = await Api.put(
          "passengers/payments/loaning/accept-request",
          reqBody: body);
      if (result.statusCode == 200) {
        _prefs.setString("transactions", json.encode(_transactions));
        return result.body;
      } else {
        _transactions.add(transaction);
        notifyListeners();
        return "Error";
      }
    } catch (_) {
      _transactions.add(transaction);
      notifyListeners();
      return "Error";
    }
  }

  List<TransactionModel> get tranactions => _transactions;
}

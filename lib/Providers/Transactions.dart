import 'package:clax/models/Transaction.dart';
import 'package:clax/services/Backend.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class TransactionsProvider extends ChangeNotifier {
  List<TransactionModel> _transactions = [];
  TransactionsProvider() {
    initialize();
  }

  // Import Local Data
  Future initialize() async {
    // Cheeck if Cache is empty
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString("transactions") != null) {
      json.decode(_prefs.getString("transactions")).forEach((transaction) =>
          _transactions.add(TransactionModel.fromJson(transaction)));
      notifyListeners();
    }
    fetchData();
  }

  Future<bool> fetchData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      Response response =
          await Api.get('passengers/payments/manage-financials/get-balance');
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

  Future<bool> cancel(String transactionId, type) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    TransactionModel transaction = (_transactions
        .where((element) => element.id == transactionId)
        .toList())[0];
    _transactions.remove(transaction);
    Map<String, String> body = {"transactionId": transactionId, "type": type};
    try {
      Response result = await Api.post("transactions/cancel", body);
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

  Future<String> add(body) async {
    try {
      Response response = await Api.post('transactions/add', body);
      if (response.statusCode == 408)
        return "تعذر الوصول للإنترنت. تأكد من اتصالك بالإنترنت و حاول مره اخرى.";
      else
        return response.body;
    } catch (_) {
      return "تعذر الوصول للإنترنت. تأكد من اتصالك بالإنترنت و حاول مره اخرى.";
    }
  }

  Future<String> accept(String transactionId) async {
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
      Response result = await Api.post("transactions/accept", body);
      if (result.statusCode == 200) {
        _prefs.setString("transactions", json.encode(_transactions));
        return result.body;
      } else {
        _transactions.add(transaction);
        notifyListeners();
        return "false";
      }
    } catch (_) {
      _transactions.add(transaction);
      notifyListeners();
      return "false";
    }
  }

  List<TransactionModel> get tranactions => _transactions;
}

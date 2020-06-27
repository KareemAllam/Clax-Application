import 'package:flutter_complete_guide/models/Transaction.dart';
import 'package:flutter_complete_guide/services/Backend.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class Transactions extends ChangeNotifier {
  List<Transaction> _transactions = [];
  Transactions() {
    initialize();
  }
  // Import Local Data
  void initialize() async {
    // Cheeck if Cache is empty
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString("transactions") != null) {
      json.decode(_prefs.getString("transactions")).forEach((transaction) =>
          _transactions.add(Transaction.fromJson(transaction)));
      notifyListeners();
    }
    fetchData();
  }

  Future<bool> fetchData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      Response response = await Api.get('transactions');
      if (response.statusCode == 200) {
        _transactions = List<Transaction>.from((json
            .decode(response.body)
            .map((transaction) => Transaction.fromJson(transaction))).toList());
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
    Transaction transaction = (_transactions
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

      if (response.statusCode == 200)
        return "Success";
      else if (response.body == "User doesn't Exist")
        return "هذا الرقم غير مربوط باي حساب. تأكد من الرقم و حاول مره اخرى.";
      else
        return "تعذر الوصول للإنترنت. تأكد من اتصالك بالإنترنت و حاول مره اخرى.";
    } catch (_) {
      return "تعذر الوصول للإنترنت. تأكد من اتصالك بالإنترنت و حاول مره اخرى.";
    }
  }

  Future<String> accept(String transactionId) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    Transaction transaction = (_transactions
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

  List<Transaction> get tranactions => _transactions;
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/utils/nameAdjustment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_complete_guide/models/CreditCard.dart';
import '../services/Backend.dart';
import 'package:http/http.dart';

class Account extends ChangeNotifier {
  double _balance = 0.0;
  List<CreditCard> _cards = [];

  Account() {
    init();
  }
  Future<bool> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _balance = prefs.getDouble('balance') ?? 0.0;
    _cards = prefs.getString("cards") == null
        ? []
        : List<CreditCard>.from(json
            .decode(prefs.getString("cards"))
            .map((card) => CreditCard.fromJson(card))).toList();

    notifyListeners();
    return await fetchData();
  }

  Future<bool> fetchData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Retreive Balance from Server
      Response balance = await Api.get('payment/get-balance');
      double balanceResult = json.decode(balance.body);
      // Retreive Cards from Server
      Response cards = await Api.get('payment/get-cards');
      List<CreditCard> cardsResult = List<CreditCard>.from(
              json.decode(cards.body).map((card) => CreditCard.fromJson(card)))
          .toList();
      // Saving Result in Cahce
      prefs.setDouble('balance', balanceResult);
      prefs.setString('cards', cards.body);
      // Assign it to state
      _balance = balanceResult;
      _cards = cardsResult;
      notifyListeners();
      return true;
    } catch (error) {
      print("No Internet Connects");
      return false;
    }
  }

  double get balance => _balance;
  set balance(double amount) {
    _balance += amount;
    notifyListeners();
  }

  List<CreditCard> get cards => _cards;

  void updateBalanceUsingCard(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _balance = _balance + value;
    prefs.setDouble('balance', _balance);
    notifyListeners();
  }

  Future<bool> removeCard(CreditCard card) async {
    _cards.remove(card);
    notifyListeners();
    try {
      Response result =
          await Api.post('payment/remove-card', {'source': card.id});
      if (result.statusCode == 200) {
        return true;
      } else {
        _cards.add(card);
        notifyListeners();
        return false;
      }
    } catch (err) {
      _cards.add(card);
      notifyListeners();
      return false;
    }
  }

  Future<String> chargeCredit(String id, String amount) async {
    try {
      Response result = await Api.post(
          'payment/charge-balance', {"source": id, "amount": amount});
      if (result.statusCode == 200) {
        _balance += int.parse(amount);
        notifyListeners();
        return result.body;
      } else {
        return "400";
      }
    } catch (_) {
      return "408";
    }
  }

  Future<String> chargePaypal(String amount) async {
    try {
      Response result = await Api.post('paypal/charge', {"amount": amount});
      if (result.statusCode == 200) {
        // _balance += int.parse(amount);
        // notifyListeners();
        return result.body;
      } else {
        return "error";
      }
    } catch (_) {
      return 'error';
    }
  }

  Future<bool> addCard(body) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    String brand = brandName(body['number']);
    try {
      Response response = await Api.post('payment/add-card', body);
      if (response.statusCode == 200) {
        _cards.add(CreditCard(
            brand: brand,
            id: response.body,
            expMonth: int.parse(body['exp_month']),
            expYear: int.parse(body['exp_year']),
            last4: body['number'].substring(12)));
        return true;
      } else {
        return false;
      }
    } catch (_) {
      return false;
    }
    // prefs.setString('cards', cards.body);
    // _cards = cardsResult;
  }
}

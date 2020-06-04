import 'dart:convert';
import 'package:clax/models/Bill.dart';
import 'package:flutter/material.dart';
import 'package:clax/utils/nameAdjustment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clax/models/CreditCard.dart';
import '../services/Backend.dart';
import 'package:http/http.dart';

class PaymentProvider extends ChangeNotifier {
  double _balance = 0.0;
  double discount = 0.0;
  List<CreditCardModel> _cards = [];
  List<BillModel> _bills = [];

  PaymentProvider() {
    init();
  }

  // Async Constructor
  Future<bool> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve Balance from cache
    _balance = prefs.getDouble('balance') ?? 0.0;

    // Retrieve Cards from cache
    _cards = prefs.getString("cards") == null
        ? []
        : List<CreditCardModel>.from(json
            .decode(prefs.getString("cards"))
            .map((card) => CreditCardModel.fromJson(card))).toList();

    // Retrieve PaymentLog from cache
    if (prefs.getString('bills') != null) {
      _bills = List<BillModel>.from(json
              .decode(prefs.getString('bills'))
              .map((bill) => BillModel.fromJson(bill))).toList() ??
          [];
    }

    notifyListeners();
    return await fetchData();
  }

  // Fetch Updated Data from Server.
  Future<bool> fetchData() async {
    try {
      // Cache Management
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Retreive Balance from Server
      Response balance =
          await Api.get('passengers/payments/manage-financials/get-balance');
      if (balance.statusCode == 200) {
        double balanceResult = json.decode(balance.body);
        // Saving Result in Cahce
        prefs.setDouble('balance', balanceResult);
        // Assigning Result to statue
        _balance = balanceResult;
      }

      // Retreive Cards from Server
      Response cards =
          await Api.get('passengers/payments/manage-financials/get-cards');
      if (cards.statusCode == 200) {
        List<CreditCardModel> cardsResult = List<CreditCardModel>.from(json
            .decode(cards.body)
            .map((card) => CreditCardModel.fromJson(card))).toList();
        // Saving Result in Cahce
        prefs.setString('cards', cards.body);
        // Assigning Result to statue
        _cards = cardsResult;
      }

      // Retreive PaymentLog from Server
      Response finance = await Api.get('passengers/payments/manage-financials');
      if (finance.statusCode == 200) {
        List bills = json.decode(finance.body);
        if (bills.length > 0) {
          // Assigning Result to statue
          _bills = List<BillModel>.from((json
              .decode(finance.body)
              .map((payment) => BillModel.fromJson(payment))).toList());
          // Saving Result in Cahce
          prefs.setString("bills", json.encode(_bills));
        } else {
          // Assigning Result to statue
          _bills = [];
          // Saving Result in Cahce
          prefs.setString("bills", json.encode(_bills));
        }
      }

      notifyListeners();
      return true;
    } catch (error) {
      return false;
    }
  }

  set setBalance(double amount) {
    _balance += amount;
  }

  List<CreditCardModel> get cards => _cards;

  // Increase++ / Decresing-- User's current balance
  void updateBalanceUsingCard(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _balance = _balance + value;
    prefs.setDouble('balance', _balance);
    notifyListeners();
  }

  // Remove a Registered Credit Card
  Future<bool> removeCard(CreditCardModel card) async {
    _cards.remove(card);
    notifyListeners();
    try {
      Response result = await Api.post(
          'payments/manage-financials/remove-card', {'source': card.id});
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

  // Charge a Credit Card ==> Increase Blanace
  Future<String> chargeCredit(String id, String amount) async {
    try {
      Response result = await Api.post(
          'passengers/payments/manage-financials/charge-credit',
          {"source": id, "amount": amount});
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

  // Charge user via Paypal ==> Increase Blanace
  Future<String> chargePaypal(String amount) async {
    try {
      Response result = await Api.post(
          'payments/manage-financials/paypal/charge-paypal',
          {"amount": amount});
      if (result.statusCode == 200) {
        _balance += int.parse(amount);
        notifyListeners();
        return result.body;
      } else {
        return "error";
      }
    } catch (_) {
      return 'error';
    }
  }

  // Add Payment Card
  Future<bool> addCard(body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String brand = brandName(body['number']);
    try {
      Response response =
          await Api.post('payments/manage-financials/add-card', body);
      if (response.statusCode == 200) {
        _cards.add(CreditCardModel(
            brand: brand,
            id: response.body,
            expMonth: int.parse(body['exp_month']),
            expYear: int.parse(body['exp_year']),
            last4: body['number'].substring(12)));
        prefs.setString("cards", json.encode(_cards));
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

  // Add a bill
  void add(String billJson) async {
    BillModel bill = BillModel.fromJson(json.decode(billJson));
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _bills.add(bill);
    _prefs.setString("bills", json.encode(_bills));
    notifyListeners();
  }

  List<BillModel> get bills => _bills;
  double get balance => _balance;
  set setDiscount(double value) {
    discount = value;
    notifyListeners();
  }
}

// Dart & Other Pacakges
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Flutter Foundation
import 'package:flutter/foundation.dart';
// Models
import 'package:clax/models/Bill.dart';
import 'package:clax/models/Error.dart';
import 'package:clax/models/Offer.dart';
import 'package:clax/models/CreditCard.dart';
// Services
import 'package:clax/services/Backend.dart';
// Utils
import 'package:clax/utils/Adjustments.dart';

class PaymentProvider extends ChangeNotifier {
  double _balance = 0.0;
  double discountPercent = 0.0;
  double discountAmount = 0;
  List<CreditCardModel> _cards = [];
  List<BillModel> _bills = [];
  List<Offer> offers = [];
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

    if (prefs.getString('offers') != null) {
      offers = List<Offer>.from(json.decode(prefs.getString('offers')).map(
            (offer) => Offer.fromJson(offer),
          ));
      bool offerRemoved = false;
      List<Offer> newOffers = [];
      offers.forEach((offer) {
        if (offer.end.isBefore(DateTime.now())) {
          offerRemoved = true;
        } else {
          newOffers.add(offer);
          if (offer.offerType == "Discount")
            discountPercent += offer.value;
          else
            discountAmount += offer.value;
        }
      });

      if (offerRemoved) {
        offers = newOffers;
        prefs.setString("offers", json.encode(offers));
      }
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
  Future<ServerResponse> chargeCredit(String id, String amount) async {
    Response result = await Api.post(
        'passengers/payments/manage-financials/charge-credit',
        {"source": id, "amount": amount});
    if (result.statusCode == 200) {
      _balance += int.parse(amount);
      notifyListeners();
      return ServerResponse(status: true, message: result.body);
    } else if (result.statusCode == 408)
      return ServerResponse(status: false, message: "تعذر الوصول للخادم");
    else
      return ServerResponse(
          status: false, message: "لا يوجد لديك رصيد لعملية التحويل.");
  }

  // Charge user via Paypal ==> Increase Blanace
  Future<ServerResponse> chargePaypal(String amount) async {
    Response result = await Api.post(
        'passengers/payments/manage-financials/paypal/charge-paypal',
        {"amount": amount});
    if (result.statusCode == 200) {
      _balance += int.parse(amount);
      notifyListeners();
      return ServerResponse(status: true, message: result.body);
    } else if (result.statusCode == 408) {
      return ServerResponse(status: false, message: "تعذر الوصول للخادم");
    } else
      return ServerResponse(
          status: false, message: "لا يوجد لديك رصيد لعملية التحويل.");
  }

  // Add Payment Card
  Future<bool> addCard(body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String brand = brandName(body['number']);
    try {
      Response response = await Api.post(
          'passengers/payments/manage-financials/add-card', body);
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
  Future add(BillModel bill) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _bills.add(bill);
    _prefs.setString("bills", json.encode(_bills));
    notifyListeners();
  }

  // add a Promo Code
  Future<ServerResponse> addOffer(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response response =
        await Api.post('passengers/settings/claim-offer', {'code': code});
    if (response.statusCode == 200) {
      Offer _offer = Offer.fromJson(
        json.decode(response.body),
      );
      offers.add(_offer);
      if (_offer.offerType == "Discount")
        discountPercent += _offer.value;
      else
        discountAmount += _offer.value;
      prefs.setString('offers', json.encode(offers));
      notifyListeners();
      return ServerResponse(status: true);
    } else if (response.statusCode == 408)
      return ServerResponse(
          status: false, message: "تأكد من اتصالك بالانترنت و حاول مره اخرى");
    else
      return ServerResponse(status: false, message: "انت مشترك بالعرض بالفعل");
  }

  // Get Current Offers
  Future<ServerResponse> fetchOffers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response response = await Api.get('passengers/settings/get-offers');
    if (response.statusCode == 200) {
      offers = List<Offer>.from(json.decode(response.body).map(
            (offer) => Offer.fromJson(offer),
          ));

      bool offerRemoved = false;
      List<Offer> newOffers = [];
      offers.forEach((offer) {
        if (offer.end.isBefore(DateTime.now())) {
          offerRemoved = true;
        } else {
          newOffers.add(offer);
          if (offer.offerType == "Discount")
            discountPercent += offer.value;
          else
            discountAmount += offer.value;
        }
      });

      if (offerRemoved) {
        offers = newOffers;
        prefs.setString("offers", json.encode(offers));
      }

      prefs.setString('offers', json.encode(offers));
      notifyListeners();
      return ServerResponse(status: true);
    } else
      return ServerResponse(
          status: false, message: "تأكد من اتصالك بالانترنت و حاول مره اخرى");
  }

  // Manual Discount Setting
  void setDiscount(double value, String type) {
    if (type == "percent")
      discountPercent = value;
    else
      discountAmount += value;
    notifyListeners();
  }

  // Getters
  List<BillModel> get bills => _bills;
  double get balance => _balance;
}

// Dart & Other Packages
import 'dart:convert';
import 'package:clax/providers/Profile.dart';
import 'package:clax/utils/password.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Providers
import 'package:clax/providers/Payment.dart';
// Models
import 'package:clax/models/Bill.dart';
import 'package:clax/models/Error.dart';
import 'package:clax/models/CreditCard.dart';
// Screens
import 'package:clax/screens/Payments/Payment_PaypalWeb.dart';

void showPayment(context, type, {card}) {
  Navigator.of(context).pop();
  showDialog(
      useRootNavigator: false,
      context: context,
      builder: (BuildContext context) {
        return PaymentPopup(card, type);
      });
}

class PaymentPopup extends StatefulWidget {
  final String type;
  final CreditCardModel card;
  PaymentPopup(this.card, this.type);
  @override
  _PaymentPopupState createState() => _PaymentPopupState();
}

class _PaymentPopupState extends State<PaymentPopup> {
  TextEditingController amountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;
  List error = [false, ""];

  Future creditCardCharge(id) async {
    setState(() {
      loading = true;
      error[0] = false;
    });
    if (amountController.text.length == 0) {
      setState(() {
        loading = false;
        error = [true, "رجاءً تأكد من معلوماتك و حاول مره اخرى"];
      });
      return false;
    } else if (passwordController.text.length == 0) {
      setState(() {
        loading = false;
        error = [true, "رجاءا، ادخل كلمة المرور الخاصة بك"];
      });
      return false;
    }

    String passHashed = Provider.of<ProfilesProvider>(context, listen: false)
        .profile
        .passHashed;
    bool passwordValidated =
        verifyPassword(passwordController.text, passHashed);
    if (passwordValidated) {
      ServerResponse result =
          await Provider.of<PaymentProvider>(context, listen: false)
              .chargeCredit(id, amountController.text);
      if (result.status) {
        BillModel bill = BillModel.fromJson(json.decode(result.message));
        Provider.of<PaymentProvider>(context, listen: false).add(bill);
        setState(() {
          loading = false;
          error = [false];
        });
        return true;
      } else {
        setState(() {
          loading = false;
          error = [true, result.message];
        });
        return false;
      }
    } else {
      setState(() {
        loading = false;
        error = [true, "كلمة المرور غير صحيح"];
      });
      return false;
    }
  }

  Future paypalCharge() async {
    setState(() {
      loading = true;
      error = [false];
    });
    if (amountController.text.length == 0) {
      setState(() {
        loading = false;
        error = [
          true,
        ];
      });
      return "error";
    } else if (passwordController.text.length == 0) {
      setState(() {
        loading = false;
        error = [true, "رجاءا، ادخل كلمة المرور الخاصة بك"];
      });
      return false;
    }

    String passHashed = Provider.of<ProfilesProvider>(context, listen: false)
        .profile
        .passHashed;
    bool passwordValidated =
        verifyPassword(passwordController.text, passHashed);

    if (passwordValidated) {
      //Api request
      setState(() {
        error = [false, "رجاءً تأكد من معلوماتك و حاول مره اخرى"];
        loading = true;
      });
      ServerResponse result =
          await Provider.of<PaymentProvider>(context, listen: false)
              .chargePaypal(amountController.text);
      if (result.status) {
        setState(() {
          loading = false;
          error = [false];
        });
        return result.message;
      } else {
        setState(() {
          loading = false;
          error = [true, result.message];
        });
      }
    } else {
      setState(() {
        loading = false;
        error = [true, "كلمة المرور غير صحيح"];
      });
      return false;
    }
  }

  void dispose() {
    super.dispose();
    amountController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.all(0),
        titlePadding: EdgeInsets.all(0),
        content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Container(
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                        controller: amountController,
                        cursorColor: Theme.of(context).primaryColor,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontFamily: "Product Sans",
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            hintText: "25",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    fontFamily: 'Product Sans',
                                    color: Colors.grey),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.add,
                            )),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3)
                        ]),
                  ),
                  Expanded(
                      child: Text("جنية مصري",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.grey)))
                ],
              ),
              TextField(
                obscureText: true,
                controller: passwordController,
                cursorColor: Theme.of(context).primaryColor,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontFamily: "Product Sans", fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    hintText: "ادخل كلمة المرور",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: Colors.grey),
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.lock,
                    )),
                keyboardType: TextInputType.text,
              )
            ]),
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: () async {
              FocusScope.of(context).unfocus();
              if (widget.type == 'card') {
                bool result = await creditCardCharge(widget.card.id);
                if (result) {
                  Navigator.pop(context, true);
                }
                if (!result && error[0] == false) {
                  Navigator.pop(context, false);
                }
              } else {
                var result = await paypalCharge();
                if (result != 'error') {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed(PaypalWeb.routeName,
                      arguments: {
                        'url': result,
                        'amount': double.parse(amountController.text)
                      });
                }
              }
            },
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: loading
                  ? SpinKitThreeBounce(size: 15, color: Colors.white)
                  : Text("اضافة",
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          error[0]
              ? Text(
                  error[1],
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: Colors.white),
                  // strutStyle: StrutStyle(forceStrutHeight: true),
                )
              : Container()
        ]));
  }
}

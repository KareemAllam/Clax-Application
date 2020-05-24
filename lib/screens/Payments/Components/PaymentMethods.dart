// Dart & Other Packages
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Providers
import 'package:clax/providers/Payment.dart';
// Models
import 'package:clax/models/CreditCard.dart';

void showPayment(context, type, {card}) {
  Navigator.of(context).pop();
  showDialog(
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
  TextEditingController amount = TextEditingController();
  bool loading = false;
  bool error = false;
  Future<bool> creditCardCharge(id) async {
    setState(() {
      loading = true;
      error = false;
    });
    if (amount.text.length == 0) {
      setState(() {
        loading = false;
        error = true;
      });
      return false;
    } else {
      //Api request
      setState(() {
        error = false;
        loading = true;
      });
      String result = await Provider.of<PaymentProvider>(context, listen: false)
          .chargeCredit(id, amount.text);
      if (result != '400' || result != "408") {
        Provider.of<PaymentProvider>(context, listen: false).add(result);
        setState(() {
          loading = false;
          error = false;
        });
        return true;
      } else {
        setState(() {
          loading = false;
          error = false;
        });
        return false;
      }
    }
  }

  Future<String> paypalCharge() async {
    setState(() {
      loading = true;
      error = false;
    });
    if (amount.text.length == 0) {
      setState(() {
        loading = false;
        error = true;
      });
      return "error";
    } else {
      //Api request
      setState(() {
        error = false;
        loading = true;
      });
      String result = await Provider.of<PaymentProvider>(context, listen: false)
          .chargePaypal(amount.text);
      if (result != 'error') {
        setState(() {
          loading = false;
          error = false;
        });
        return result;
      } else {
        setState(() {
          loading = false;
          error = false;
        });
        return "error";
      }
    }
  }

  void dispose() {
    super.dispose();
    amount.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.all(0),
        titlePadding: EdgeInsets.all(0),
        title: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: Text(
              "حدد المبلغ المناسب:",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white),
            )),
        content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Container(
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                          controller: amount,
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Colors.grey)))
                  ],
                ),
              ]),
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              )),
          GestureDetector(
            onTap: () async {
              if (widget.type == 'card') {
                bool result = await creditCardCharge(widget.card.id);
                if (result) {
                  Navigator.pop(context, true);
                }
                if (!result && error == false) {
                  Navigator.pop(context, false);
                }
              } else {
                String result = await paypalCharge();
                if (result != 'error') {
                  Navigator.pop(context);
                  Navigator.of(context)
                      .pushNamed('/payment/paypal', arguments: {'url': result});
                }
              }
            },
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              height: 40,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: loading
                  ? SpinKitThreeBounce(size: 15, color: Colors.white)
                  : Text("اضافة",
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.values[6])),
            ),
          ),
          error
              ? Text(
                  "رجاءً تأكد من معلوماتك و حاول مره اخرى",
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

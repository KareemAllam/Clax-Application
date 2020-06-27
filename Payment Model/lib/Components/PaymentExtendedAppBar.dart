import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Provider/Account.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../widgets/BottomSheetTitle.dart';
import './PaymentMethods.dart';

class PaymentAppBarBottom extends StatefulWidget {
  @override
  _PaymentAppBarBottomState createState() => _PaymentAppBarBottomState();
}

class _PaymentAppBarBottomState extends State<PaymentAppBarBottom> {
  _PaymentAppBarBottomState();
  String urll = "error";
  Future<bool> checkData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Consumer<Account>(
        builder: (context, account, child) => Text(
          account.balance.toString(),
          style: TextStyle(
              fontSize: width * 0.15,
              fontFamily: 'Product Sans',
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
      Builder(
        builder: (context) => Material(
          borderRadius: BorderRadius.all(Radius.circular(width)),
          color: Theme.of(context).accentColor,
          elevation: 2.0,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(width)),
            splashColor: Colors.orange,
            onTap: () async {
              bool result = await checkData();
              if (result)
                showModalBottomSheet<bool>(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.transparent,
                    // isScrollControlled: true,
                    isDismissible: true,
                    builder: (BuildContext context) {
                      return CardsList();
                    });
              else
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "تعذر الوصول للإنترنت. تأكد من اتصالك بالإنترنت و حاول مره اخرى.",
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Colors.white))));
            },
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: width * 0.8),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                child: Text(
                  "اضافة المزيد",
                  style: Theme.of(context).textTheme.button.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}

class CardsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cards = Provider.of<Account>(context);
    return Column(mainAxisSize: MainAxisSize.min, children: [
      BottomSheetTitle(
          icon: Icons.account_balance_wallet,
          title: "اختر طريقة الدفع المناسبة:"),
      ...cards.cards.map(
        (card) => Material(
          color: Colors.white,
          child: InkWell(
              splashColor: Colors.grey,
              onTap: () async {
                showPayment(context, "card", card: card);
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: Row(children: <Widget>[
                    Container(
                      child: Row(children: <Widget>[
                        card.brand == 'Visa'
                            ? Icon(FontAwesomeIcons.ccVisa,
                                color: Colors.blueAccent)
                            : Icon(FontAwesomeIcons.ccMastercard,
                                color: Colors.red),
                        SizedBox(width: 25),
                        Text("**** " + card.last4,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                fontFamily: 'Product Sans',
                                color: Colors.black87,
                                fontWeight: FontWeight.w600))
                      ]),
                    ),
                    Spacer(),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(0),
                            icon: Icon(Icons.delete_forever,
                                color: Colors.black38),
                            onPressed: () async {
                              bool result = await cards.removeCard(card);
                              if (!result) print("No Internet Connection");
                              // remove(card);
                              // widget.updateCard(card, false);
                            }))
                  ]))),
        ),
      ),
      Material(
          color: Colors.white,
          child: InkWell(
            splashColor: Colors.grey,
            onTap: () {
              showPayment(context, "Paypal");
            },
            child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(children: <Widget>[
                  Icon(
                    FontAwesomeIcons.paypal,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 25),
                  Text('باي بال',
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          color: Colors.black87,
                          fontWeight: FontWeight.w600))
                ])),
          )),
      cards.cards.length < 3
          ? Material(
              color: Colors.white,
              child: InkWell(
                splashColor: Colors.grey,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/payment/add');
                },
                child: Container(
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(children: <Widget>[
                      Icon(Icons.add_circle_outline, color: Colors.black54),
                      SizedBox(width: 20),
                      Text("اضافة حساب جديد",
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              color: Colors.black87,
                              fontWeight: FontWeight.w600))
                    ])),
              ))
          : Container(),
      SizedBox(
        height: 40,
        child: Container(color: Colors.white),
      )
    ]);
  }
}

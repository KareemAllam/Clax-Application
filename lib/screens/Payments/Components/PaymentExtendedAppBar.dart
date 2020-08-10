// Dart & Other Packages
import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Providers
import 'package:clax/providers/Payment.dart';
import 'package:clax/providers/Profile.dart';
// Models
import 'package:clax/models/Profile.dart';
// Screens
import 'package:clax/screens/Login/Verification.dart';
// Components
import 'package:clax/screens/Payments/Components/PaymentMethods.dart';
// Widgets
import 'package:clax/widgets/BottomSheetTitle.dart';

class PaymentAppBarBottom extends StatefulWidget {
  @override
  _PaymentAppBarBottomState createState() => _PaymentAppBarBottomState();
}

class _PaymentAppBarBottomState extends State<PaymentAppBarBottom> {
  _PaymentAppBarBottomState();
  String urll = "error";
  ProfileModel _profile;

  Future<bool> checkInternet() async {
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    _profile = Provider.of<ProfilesProvider>(context).profile;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    return _profile == null
        ? SpinKitCircle(color: Colors.white)
        : Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Consumer<PaymentProvider>(
              builder: (context, account, child) => Text(
                account.balance.toString(),
                style: TextStyle(
                    fontSize: width * 0.15,
                    fontFamily: 'Product Sans',
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Material(
              borderRadius: BorderRadius.all(Radius.circular(width)),
              color: theme.accentColor,
              elevation: 2.0,
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(width)),
                splashColor: Colors.orange,
                onTap: () async {
                  bool result = await checkInternet();
                  if (result) {
                    if (_profile.phoneVerified) {
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
                    } else
                      Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: theme.primaryColor,
                          action: SnackBarAction(
                              label: "تفعيل",
                              onPressed: () => Navigator.of(context)
                                  .pushNamed(Verification.routeName)),
                          content: Text("برجاء تفعيل هاتفك اولاًَ.",
                              style: theme.textTheme.subtitle2
                                  .copyWith(color: Colors.white))));
                  } else
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "تعذر الوصول للإنترنت. تأكد من اتصالك بالإنترنت و حاول مره اخرى.",
                            style: theme.textTheme.caption
                                .copyWith(color: Colors.white))));
                },
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: width * 0.8),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                    child: Text(
                      "اضافة المزيد",
                      style: theme.textTheme.button.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
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
    var cards = Provider.of<PaymentProvider>(context);
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

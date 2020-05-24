// Dart & Other Packages
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Providers
import 'package:clax/providers/Payment.dart';
// Components
import 'package:clax/screens/Payments/Components/CreditCardType.dart';
// Widgets
import 'package:clax/widgets/FormGeneral.dart';

class PaymentAdd extends StatefulWidget {
  static const routeName = '/payment/add';
  @override
  _PaymentAddState createState() => _PaymentAddState();
}

class _PaymentAddState extends State<PaymentAdd> {
  TextEditingController _cardNumber = TextEditingController();
  TextEditingController _ccvNumber = TextEditingController();
  FocusNode _cardNumberFocus = FocusNode();
  FocusNode _ccvNumberFocus = FocusNode();
  String _cardNumberPlaceholder = 'اكتب رقم بطاقة الدفع الخاص بك';
  String _datePlaceholder = "اختار موعد انتهاء بطاقتك";
  String _ccvNumberPlaceholder = "اكتب رقم بطاقة الدفع الخاص بك";
  DateTime _expDate;
  bool err = false;
  bool loading = false;
  Widget _selectedWidget = Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Text("Debit Card",
          style: TextStyle(
              fontSize: 60,
              color: Colors.deepPurple,
              fontFamily: "Product Sans")));

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
    _cardNumber.dispose();
    _ccvNumber.dispose();
  }

  void changeCardType(value) {
    var visa = RegExp(
      r"^4[0-9]{12}(?:[0-9]{3})?$",
    );
    var mastercard = RegExp(
      r"^(?:5[1-5][0-9]{2}|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)[0-9]{12}$",
    );

    if (visa.hasMatch(value))
      setState(() {
        _selectedWidget = Container(
            child: Image(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.width * 0.2,
          image: AssetImage('assets/images/visa.png'),
          fit: BoxFit.fill,
        ));
      });
    else if (mastercard.hasMatch(value))
      setState(() {
        _selectedWidget = Container(
            child: Image(
          alignment: Alignment.center,
          fit: BoxFit.fill,
          height: MediaQuery.of(context).size.width * 0.3,
          image: AssetImage('assets/images/mastercard.png'),
        ));
      });
    else
      setState(() {
        _selectedWidget = Text("Debit Card",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.13,
                color: Colors.deepPurple,
                fontFamily: "Product Sans",
                fontWeight: FontWeight.bold));
      });
  }

  void validatation() async {
    setState(() {
      err = false;
    });
    bool error = false;
    if (_cardNumber.text == "" || _cardNumber.text.length < 16) {
      setState(() {
        _cardNumberPlaceholder = "من فضلك، اكتب رقم بطاقتك الالكترونية";
        error = true;
      });
    }
    if (_expDate == null) {
      setState(() {
        _datePlaceholder = "من فضلك، اختر موعد انتهاء البطاقة";
        error = true;
      });
    }
    if (_ccvNumber.text == "" || _ccvNumber.text.length < 3) {
      setState(() {
        _ccvNumberPlaceholder =
            "من فضلك، اكتب التلات ارقام الخاصه بتأكيد البطاقة";
        error = true;
      });
    }
    if (error == true) {
      setState(() {
        error = false;
      });
      return;
    } else {
      setState(() {
        err = false;
        loading = true;
        _cardNumberPlaceholder = '';
        _datePlaceholder = '';
        _ccvNumberPlaceholder = '';
      });
      int year = _expDate.year;
      int month = _expDate.month;
      Map<String, String> body = {
        "number": _cardNumber.text,
        "exp_year": "$year",
        "exp_month": "$month",
        "cvc": _ccvNumber.text
      };
      bool result = await Provider.of<PaymentProvider>(context, listen: false)
          .addCard(body);
      print(result);
      if (result) {
        Navigator.pop(context);
      } else {
        setState(() {
          loading = false;
          err = true;
        });
      }
    }
  }

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            title: Text('ضيف حساب جديد',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.white))),
        body: GestureDetector(
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CreditCardType(selectedWidget: _selectedWidget),
              FormGeneral(
                  title: 'رقم البطاقة:',
                  widget: Container(
                    padding: EdgeInsets.only(right: 20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black38)),
                    child: TextField(
                      focusNode: _cardNumberFocus,
                      keyboardType: TextInputType.number,
                      controller: _cardNumber,
                      onEditingComplete: () {
                        _cardNumberFocus.unfocus();
                        FocusScope.of(context).requestFocus(_ccvNumberFocus);
                      },
                      scrollPadding: EdgeInsets.all(0),
                      inputFormatters: [
                        BlacklistingTextInputFormatter(RegExp('[\\-|\\ ]')),
                        WhitelistingTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(16)
                      ],
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontFamily: "Product Sans",
                          fontWeight: FontWeight.bold),
                      onSubmitted: changeCardType,
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        icon: Icon(Icons.payment),
                        focusedBorder: InputBorder.none,
                        hintText: "4242424242424242",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(
                                fontFamily: 'Product Sans', color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  placeholder: _cardNumberPlaceholder),
              // ---------------------------------------
              SizedBox(height: 20),
              FormGeneral(
                title: "رقم تأكيد البطاقة cvv:",
                placeholder: _ccvNumberPlaceholder,
                widget: Container(
                  padding: EdgeInsets.only(right: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black38)),
                  child: TextField(
                    focusNode: _ccvNumberFocus,
                    onEditingComplete: () => _ccvNumberFocus.unfocus(),
                    keyboardType: TextInputType.number,
                    controller: _ccvNumber,
                    scrollPadding: EdgeInsets.all(0),
                    inputFormatters: [
                      BlacklistingTextInputFormatter(RegExp('[\\-|\\ ]')),
                      WhitelistingTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3)
                    ],
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontFamily: "Product Sans",
                        fontWeight: FontWeight.bold),
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      icon: Icon(Icons.payment),
                      focusedBorder: InputBorder.none,
                      hintText: "123",
                      hintStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontFamily: 'Product Sans', color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              //-----------------------------------------------------------------
              SizedBox(height: 20),
              FormGeneral(
                title: "موعد الانتهاء:",
                widget: GestureDetector(
                  onTap: () {
                    showMonthPicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate:
                                DateTime.now().subtract(Duration(days: 360)),
                            lastDate:
                                DateTime.now().add(Duration(days: 360 * 2)))
                        .then((value) => setState(() {
                              _expDate = value;
                            }));
                  },
                  child: Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black38)),
                      child: _expDate == null
                          ? Row(
                              children: <Widget>[
                                Icon(Icons.date_range, color: Colors.grey),
                                SizedBox(width: 15),
                                Text(
                                  "21/2022",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                          fontFamily: 'Product Sans',
                                          color: Colors.grey),
                                )
                              ],
                            )
                          : Row(
                              children: <Widget>[
                                Icon(Icons.date_range, color: Colors.grey),
                                SizedBox(width: 15),
                                Expanded(
                                    child: Container(
                                        child: Row(
                                  children: <Widget>[
                                    Text("سنة:",
                                        strutStyle:
                                            StrutStyle(forceStrutHeight: true),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    SizedBox(width: 12),
                                    Text(
                                      "${_expDate.year}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(
                                              fontFamily: "Product Sans",
                                              fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ))),
                                Expanded(
                                    child: Container(
                                        child: Row(
                                  children: <Widget>[
                                    Text("شهر:",
                                        strutStyle:
                                            StrutStyle(forceStrutHeight: true),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    SizedBox(width: 12),
                                    Text("${_expDate.month}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(
                                                fontFamily: "Product Sans",
                                                fontWeight: FontWeight.bold))
                                  ],
                                )))
                              ],
                            )),
                ),
                placeholder: _datePlaceholder,
              ),
              Container(
                  margin: EdgeInsets.only(top: 50),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: loading
                      ? SpinKitThreeBounce(
                          size: 30, color: Theme.of(context).primaryColor)
                      : RaisedButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: validatation,
                          child: Text("اضافة",
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                          padding: EdgeInsets.symmetric(
                              vertical: 5, horizontal: width * 0.2),
                          shape: StadiumBorder(),
                        ))
            ],
          )),
        ));
  }
}

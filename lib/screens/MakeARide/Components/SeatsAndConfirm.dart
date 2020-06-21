import 'package:clax/providers/Payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeatsAndConfirm extends StatefulWidget {
  final double balance;
  final double pricePerSeat;
  final Function startSearchingForDriver;
  SeatsAndConfirm(
      this.balance, this.pricePerSeat, this.startSearchingForDriver);
  @override
  _SeatsAndConfirmState createState() => _SeatsAndConfirmState();
}

class _SeatsAndConfirmState extends State<SeatsAndConfirm> {
  int _seatsCount = 1;
  double balance;
  double discountPercent;
  double discountAmount;
  double finalPrice;
  bool onlinePayment = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    balance = Provider.of<PaymentProvider>(context).balance;
    discountAmount = Provider.of<PaymentProvider>(context).discountAmount;
    discountPercent = Provider.of<PaymentProvider>(context).discountPercent;
  }

  void areYouSure() {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("الغاء",
          style: TextStyle(
              color: Colors.white60,
              fontWeight: FontWeight.bold)), // Dismiss the Alert Dialoge Box
      onPressed: Navigator.of(context).pop,
    );
    Widget continueButton = FlatButton(
      child: Text("نعم",
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold)),
      onPressed: () async {
        // Start Searching for Driver
        // Pass Data to Parent Widget
        widget.startSearchingForDriver(_seatsCount, finalPrice, onlinePayment);
        // Dismiss the Alert Dialoge Box
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      title: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5))),
        padding: EdgeInsets.only(top: 20, right: 15, left: 15, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "هل تريد متابعه طلبك؟",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontWeight: FontWeight.values[5]),
            ),
            SizedBox(height: 2),
            Text("سيتم خصم التكلفة منك عند قبول السائق طلبك.",
                style: Theme.of(context).textTheme.caption)
          ],
        ),
      ),
      buttonPadding: EdgeInsets.all(0),
      actionsPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(0),
      content: Container(
          color: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              continueButton,
              cancelButton,
            ],
          )),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double tripPrice = ((_seatsCount) * widget.pricePerSeat).toDouble();
    double discount = 0;
    if (discountAmount != 0) discount = (tripPrice - discountAmount);
    if (discountPercent != 0) discount *= discountPercent;
    if (discount != 0) discount = double.parse(discount.toStringAsFixed(2));
    finalPrice = tripPrice - discount;
    bool canPay =
        (balance - ((_seatsCount + 1) * widget.pricePerSeat).toDouble()) >= 0 &&
            _seatsCount <= 2;
    // Decoration Vars
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    Color primaryColor = theme.primaryColor;

    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10),
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.event_seat,
                        color: Theme.of(context).primaryColor),
                    SizedBox(width: 24),
                    Text(
                      "عدد الكراسي",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                Row(children: <Widget>[
                  IconButton(
                      alignment: Alignment.centerRight,
                      iconSize: 30,
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                        Icons.add_box,
                        color: canPay
                            ? Theme.of(context).accentColor
                            : Colors.grey[350],
                      ),
                      onPressed: () {
                        if (_seatsCount != 3 && canPay)
                          setState(() {
                            _seatsCount += 1;
                          });
                      }),
                  Text(
                    _seatsCount.toString(),
                    style: textTheme.subtitle2
                        .copyWith(fontFamily: "Product Sans"),
                  ),
                  IconButton(
                      alignment: Alignment.centerLeft,
                      iconSize: 30,
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                        Icons.indeterminate_check_box,
                        color: _seatsCount > 1 ? Colors.red : Colors.grey[350],
                      ),
                      onPressed: () {
                        if (_seatsCount != 1)
                          setState(() {
                            _seatsCount -= 1;
                          });
                      })
                ])
              ],
            ),
          ),
          SizedBox(height: 8),
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              padding: EdgeInsets.only(left: 8),
              child: Column(
                children: <Widget>[
                  RadioListTile<bool>(
                    activeColor: Theme.of(context).primaryColor,
                    secondary: Icon(Icons.credit_card,
                        color: onlinePayment
                            ? Theme.of(context).primaryColor
                            : Colors.grey[350]),
                    title: Text(
                      "ادفع اونلاين",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    value: true,
                    groupValue: onlinePayment,
                    onChanged: (bool value) {
                      setState(() {
                        onlinePayment = value;
                      });
                    },
                  ),
                  Divider(height: 1),
                  RadioListTile<bool>(
                    activeColor: Theme.of(context).primaryColor,
                    secondary: Icon(Icons.monetization_on,
                        color: !onlinePayment
                            ? Theme.of(context).primaryColor
                            : Colors.grey[350]),
                    title: Text(
                      'ادفع كاش',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    value: false,
                    groupValue: onlinePayment,
                    onChanged: (bool value) {
                      setState(() {
                        onlinePayment = value;
                      });
                    },
                  ),
                ],
              )),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                if (discount != 0)
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "سعر الرحلة:",
                        style: textTheme.subtitle2.copyWith(color: Colors.grey),
                      ),
                      Spacer(),
                      Text(
                        '$tripPrice جنية',
                        style: textTheme.subtitle2.copyWith(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                if (discount != 0)
                  Row(
                    children: <Widget>[
                      Text("مقدار الخصم:",
                          style:
                              textTheme.subtitle2.copyWith(color: Colors.grey)),
                      Spacer(),
                      Text(
                        '$discount جنية',
                        style: textTheme.subtitle2.copyWith(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                Row(
                  children: <Widget>[
                    Text("اجمالي الرحلة:",
                        style:
                            textTheme.subtitle2.copyWith(color: Colors.grey)),
                    Spacer(),
                    Text(
                      '$finalPrice جنية',
                      style: textTheme.subtitle2.copyWith(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("هيبقى معاك:",
                        style:
                            textTheme.subtitle2.copyWith(color: Colors.grey)),
                    Spacer(),
                    Text(
                      '${balance - (_seatsCount * widget.pricePerSeat).toDouble()} جنية',
                      style: textTheme.subtitle2.copyWith(
                          color: Colors.black54, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: areYouSure,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 15),
              color: primaryColor,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.search, color: Theme.of(context).accentColor),
                    SizedBox(width: 8),
                    Text(
                      "ابحث عن سائق",
                      style: textTheme.subtitle2.copyWith(color: Colors.white),
                    )
                  ]),
            ),
          )
        ],
      ),
    );
  }
}

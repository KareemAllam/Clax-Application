import 'package:clax/providers/CurrentTrip.dart';
import 'package:clax/providers/Payment.dart';
import 'package:clax/widgets/LinePaint.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RideInfo extends StatefulWidget {
  static const titleName = 'معلومات الرحلة';
  final Function changeWidget;
  RideInfo(this.changeWidget);
  @override
  _RideInfoState createState() => _RideInfoState();
}

class _RideInfoState extends State<RideInfo> {
  int _seatsCount = 1;
  double balance;
  double finalPrice;
  Map<String, dynamic> arguments;
  Map<String, dynamic> line;
  Map<String, dynamic> destination;
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
      onPressed: () {
        // Dismiss the Alert Dialoge Box
        Provider.of<CurrentTripProvider>(context, listen: false)
            .searchingDriverState(finalPrice);
        widget.changeWidget();
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

  void didChangeDependencies() {
    super.didChangeDependencies();
    balance = Provider.of<PaymentProvider>(context).balance;
    arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    line = arguments["line"];
    destination = arguments["destination"];
  }

  @override
  Widget build(BuildContext context) {
    // Balance Informations
    finalPrice = ((_seatsCount) * line['cost']).toDouble();
    bool canPay =
        (balance - ((_seatsCount + 1) * line['cost']).toDouble()) >= 0;
    // Decoration Vars
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    Color primaryColor = theme.primaryColor;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "خط الرحلة:",
                  style:
                      textTheme.headline6.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.close, color: primaryColor),
                    Stack(alignment: Alignment.center, children: <Widget>[
                      CustomPaint(
                          willChange: false,
                          isComplex: false,
                          painter: LineDashedPainter(),
                          size: Size(width - 100, 0)),
                      Container(
                        color: Colors.white,
                        child: Icon(Icons.gps_fixed, color: primaryColor),
                      )
                    ]),
                    Icon(
                      Icons.location_on,
                      size: 30,
                      color: primaryColor,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      line['from'],
                      style: textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    Text(destination['name']),
                    Text(line['to'],
                        style: textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.black87))
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "عدد الكراسي:",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Row(children: <Widget>[
                  IconButton(
                      alignment: Alignment.centerRight,
                      iconSize: 30,
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                        Icons.add_box,
                        color: canPay ? Colors.green : Colors.grey,
                      ),
                      onPressed: () {
                        if (_seatsCount != 3 && canPay)
                          setState(() {
                            _seatsCount += 1;
                          });
                      }),
                  Text(
                    _seatsCount.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(fontFamily: "Product Sans"),
                  ),
                  IconButton(
                      alignment: Alignment.centerLeft,
                      iconSize: 30,
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                        Icons.indeterminate_check_box,
                        color: _seatsCount > 1 ? Colors.red : Colors.grey,
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
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "هتدفع اجمالي:",
                      style: textTheme.subtitle2.copyWith(color: Colors.grey),
                    ),
                    Spacer(),
                    Text(
                      '${(_seatsCount * line['cost']).toDouble()} جنية',
                      style: textTheme.subtitle2.copyWith(
                          color: Colors.grey, fontWeight: FontWeight.bold),
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
                      '${balance - (_seatsCount * line['cost']).toDouble()} جنية',
                      style: textTheme.subtitle2.copyWith(
                          color: Colors.grey, fontWeight: FontWeight.bold),
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
                    SizedBox(width: 5),
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

import 'package:clax/providers/Payment.dart';
import 'package:clax/widgets/LinePaint.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RideInfo extends StatefulWidget {
  static const routeName = 'rideInfo';

  @override
  _RideInfoState createState() => _RideInfoState();
}

class _RideInfoState extends State<RideInfo> {
  void sendRequest() {}
  int _seatsCount = 1;

  Widget tripInfo(double balance, TextTheme textTheme, Color primaryColor,
      double width, line, destination) {
    return Column(
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
                      color: Colors.green,
                    ),
                    onPressed: () {
                      if (_seatsCount != 3)
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
                      color: Colors.red,
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
                      style: textTheme.subtitle2.copyWith(color: Colors.grey)),
                  Spacer(),
                  Text(
                    '$balance جنية',
                    style: textTheme.subtitle2.copyWith(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          color: primaryColor,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.search, color: Theme.of(context).accentColor),
                FlatButton(
                    onPressed: sendRequest,
                    child: Text(
                      "ابحث عن سائق",
                      style: textTheme.subtitle2.copyWith(color: Colors.white),
                    ))
              ]),
        )
      ],
    );
  }

  Widget build(BuildContext context) {
    // Navigation Vars
    Map<String, dynamic> arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    Map<String, dynamic> line = arguments["line"];
    Map<String, dynamic> destination = arguments["destination"];

    // Balance Informations
    double balance = Provider.of<PaymentProvider>(context).balance;
    // Decoration Vars
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    Color primaryColor = theme.primaryColor;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          title: Text(
        'معلومات الرحلة',
        style:
            Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
      )),
      body:
          tripInfo(balance, textTheme, primaryColor, width, line, destination),
    );
  }
}

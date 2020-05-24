import 'package:clax/appMap.dart';
import 'package:clax/models/Station.dart';
import 'package:clax/providers/Map.dart';
import 'package:clax/providers/Payment.dart';
import 'package:clax/screens/Home/RideInfo.dart';
// import 'package:clax/screens/Home/GoogleMap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class StartARide extends StatefulWidget {
  static const routeName = "startARide";
  @override
  _StartARideState createState() => _StartARideState();
}

class _StartARideState extends State<StartARide> {
  List<Station> stations;
  TextEditingController _controllerPlace = new TextEditingController();
  List<Station> _searchResult = [];

  void searchStation(String station) {
    if (station == '')
      setState(() {
        _searchResult = [];
      });
    else
      setState(() {
        _searchResult = stations
            .where((element) => element.from.contains(station))
            .toList();
      });
  }

  void noEnoughMoneyDB() {
    TextTheme textTheme = Theme.of(context).textTheme;
    Color primaryColor = Theme.of(context).primaryColor;
    Color accentColor = Theme.of(context).accentColor;
    // set up the button
    Widget okButton = FlatButton(
      child: Text("حسنا", style: TextStyle(color: Colors.white)),
      onPressed: () {},
    );
    // set charge the button
    Widget chargeNow = FlatButton(
      child: Text("اشحن الان", style: TextStyle(color: Colors.white)),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text(""),
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: Container(
          color: primaryColor,
          child: Row(
            children: <Widget>[
              Icon(Icons.sentiment_dissatisfied, size: 20, color: accentColor),
              SizedBox(width: 5),
              Text("عذراً",
                  style: textTheme.bodyText1.copyWith(color: Colors.white))
            ],
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Text("لا يوجد رصيد كافي في محفظتك",
                textAlign: TextAlign.right, style: textTheme.bodyText2),
          ),
          Container(
            color: primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[okButton, chargeNow],
            ),
          ),
        ],
      ),
    );
    // actions: [chargeNow, okButton],

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  List<Widget> renderLines(balance) {
    List<Widget> list = List<Widget>();
    _searchResult.forEach((_station) {
      _station.lines.forEach((line) {
        list.add(Container(
          decoration: BoxDecoration(
              color: Colors.white60,
              border: Border(bottom: BorderSide(color: Colors.black26))),
          child: ListTile(
            onTap: () {
              if (balance < _station.cost.toDouble())
                noEnoughMoneyDB();
              else {
                // Navigate to Info Screen
                Navigator.of(context).pushNamed(RideInfo.routeName, arguments: {
                  "line": {
                    "from": _station.from,
                    "to": _station.to,
                    "lineId": _station.id,
                    "cost": _station.cost
                  },
                  "destination": {
                    "name": line.name,
                    "coordinate": line.coordinates,
                  },
                });
              }
            },
            isThreeLine: false,
            dense: true,
            title:
                Text(line.name, style: Theme.of(context).textTheme.subtitle2),
            subtitle: Text('${_station.cost} جنيه',
                style: Theme.of(context).textTheme.caption),
            leading: Icon(
              Icons.room,
              color: Theme.of(context).primaryColor,
            ),
            trailing: Icon(Icons.navigate_next),
          ),
        ));
      });
    });
    return list;
  }

  @override
  void initState() {
    super.initState();
    stations = getStaticData();
  }

  void dispose() {
    super.dispose();
    _controllerPlace.dispose();
  }

  Widget build(BuildContext context) {
    Provider.of<CustomMap>(context).setDriverId = "driver123";
    double balance = Provider.of<PaymentProvider>(context).balance;
    ThemeData theme = Theme.of(context);
    List<Widget> lines = renderLines(balance);
    return stations == null
        ? SpinKitCircle(color: theme.primaryColor)
        : Column(
            mainAxisSize: MainAxisSize.max,
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
                TextField(
                    controller: _controllerPlace,
                    onChanged: (value) => searchStation(value),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: InputBorder.none,
                        // contentPadding: EdgeInsets.all(0),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'اختار المحطه',
                        prefixIcon: Icon(
                          Icons.my_location,
                        ),
                        suffixIcon: new IconButton(
                          icon: new Icon(Icons.cancel),
                          onPressed: () {
                            _controllerPlace.clear();
                          },
                        ))),
                Expanded(
                  child: _searchResult.length == 0
                      ? Center(
                          child: Text(
                          "قم باختيار المحطه المناسبة لك",
                          style: TextStyle(color: Colors.grey),
                        ))
                      : ListView.builder(
                          itemCount: lines.length,
                          physics: AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          itemBuilder: (context, index) => lines[index],
                        ),
                )
              ]);
  }
}

//  TextField(
//                   controller: _controllerPlace,
//                   keyboardType: TextInputType.number,
//                   inputFormatters: <TextInputFormatter>[
//                     WhitelistingTextInputFormatter.digitsOnly
//                   ],
//                   maxLength: 1,
//                   decoration: InputDecoration(
//                       counterText: '',
//                       enabledBorder: InputBorder.none,
//                       // contentPadding: EdgeInsets.all(0),
//                       filled: true,
//                       fillColor: Colors.white,
//                       hintText: 'هتحجز كام مكان',
//                       prefixIcon: Icon(
//                         Icons.people_outline,
//                       ),
//                       suffixIcon: new IconButton(
//                         icon: new Icon(Icons.cancel),
//                         onPressed: () {
//                           _controllerPlace.clear();
//                         },
//                       )))

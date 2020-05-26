import 'package:clax/appMap.dart';
import 'package:clax/models/Station.dart';
import 'package:clax/providers/Map.dart';
import 'package:clax/providers/Payment.dart';
// import 'package:clax/screens/Home/GoogleMap.dart';
import 'package:clax/screens/MakeARide/StartARide.dart';
import 'package:clax/screens/Payments/Payment_HomeScreen.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// import 'package:clax/screens/Home/GoogleMap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class RidePickLocation extends StatefulWidget {
  static const routeName = "ridePickLocation";
  @override
  _RidePickLocationState createState() => _RidePickLocationState();
}

class _RidePickLocationState extends State<RidePickLocation> {
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
    // Color accentColor = Theme.of(context).accentColor;
    // set up the button
    Widget okButton = FlatButton(
      child: Text("حسنا", style: TextStyle(color: Colors.black54)),
      onPressed: Navigator.of(context).pop,
    );
    // set charge the button
    Widget chargeNow = FlatButton(
      child: Text("اشحن الان", style: TextStyle(color: primaryColor)),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(PaymentScreen.routeName);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text("عذرب"),
      contentPadding: EdgeInsets.only(top: 20, right: 15, bottom: 20),
      content:
          Text("عذراً، لو يوجد لديك رصيد كافي", style: textTheme.bodyText2),
      actions: [
        chargeNow,
        okButton,
      ],
    );

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
                FocusScope.of(context).unfocus();
                // Navigate to Info Screen
                Navigator.of(context)
                    .pushNamed(StartARide.routeName, arguments: {
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
    Provider.of<MapProvider>(context).setDriverId = "driver123";
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

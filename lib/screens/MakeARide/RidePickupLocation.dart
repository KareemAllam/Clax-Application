// Dart & Other Packages
import 'package:clax/screens/MakeARide/Components/RideSearching.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
// Flutter material Components
import 'package:flutter/material.dart';
// Models
import 'package:clax/models/Station.dart';
// Static Data
import 'package:clax/appMap.dart';
// Providers
import 'package:clax/providers/CurrentTrip.dart';
import 'package:clax/providers/Payment.dart';
// Screens
import 'package:clax/screens/MakeARide/GoogleMap.dart';
import 'package:clax/screens/MakeARide/StartARide.dart';
import 'package:clax/screens/Payments/Payment_HomeScreen.dart';
// Components
import 'package:clax/screens/MakeARide/Components/FlipIcon.dart';

class RidePickLocation extends StatefulWidget {
  static const routeName = "ridePickLocation";
  @override
  _RidePickLocationState createState() => _RidePickLocationState();
}

class _RidePickLocationState extends State<RidePickLocation> {
  List<Station> stations;
  TextEditingController _controllerPlace = new TextEditingController();
  List<Station> _searchResult = [];
  Map<String, dynamic> tripInfoRetreived;
  bool busy = false;
  String driverId;
  double balance;
  ThemeData theme;
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
    // set up the button
    Widget okButton = FlatButton(
      child: Text("حسنا",
          style: TextStyle(color: Colors.white60, fontWeight: FontWeight.bold)),
      onPressed: Navigator.of(context).pop,
    );
    // set charge the button
    Widget chargeNow = FlatButton(
      child: Text("اشحن الان",
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold)),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pushNamed(PaymentScreen.routeName);
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
              "لا يوجد لديك رصيد كافي",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontWeight: FontWeight.values[5]),
            ),
            SizedBox(height: 2),
            Text("يمكن شحن رصيدك في اي وقت عبر الانترنت.",
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
              chargeNow,
              okButton,
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

  List<Widget> renderLines(balance) {
    List<Widget> list = List<Widget>();
    _searchResult.forEach((_station) {
      _station.lines.forEach((line) {
        list.add(Container(
          decoration: BoxDecoration(
              color: Colors.white,
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
            leading: Icon(Icons.room,
                color: Theme.of(context).primaryColor, size: 30),
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

  void didChangeDependencies() {
    super.didChangeDependencies();
    busy = Provider.of<CurrentTripProvider>(context).busy;
    tripInfoRetreived =
        Provider.of<CurrentTripProvider>(context).currentDriverInfo;
    balance = Provider.of<PaymentProvider>(context).balance;
    theme = Theme.of(context);
  }

  @override
  void dispose() {
    super.dispose();
    _controllerPlace.dispose();
  }

  Widget build(BuildContext context) {
    List<Widget> lines = renderLines(balance);

    return stations == null
        ? SpinKitCircle(color: theme.primaryColor)
        : !busy
            ? Column(
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
                        filled: true,
                        fillColor: Colors.white54,
                        hintText: 'اختار المحطه',
                        prefixIcon: Icon(
                          Icons.my_location,
                        ),
                        suffixIcon: _controllerPlace.text != ""
                            ? IconButton(
                                icon: new Icon(Icons.cancel),
                                onPressed: () {
                                  _searchResult = [];
                                  _controllerPlace.clear();
                                  setState(() {});
                                },
                              )
                            : SizedBox(),
                      ),
                    ),
                    Expanded(
                      child: _searchResult.length == 0
                          ? Center(
                              child: Text(
                              "قم باختيار المحطه المناسبة لك",
                              style: TextStyle(color: Colors.grey),
                            ))
                          : ListView.builder(
                              itemCount: lines.length,
                              itemExtent: 70,
                              physics: AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              itemBuilder: (context, index) => lines[index],
                            ),
                    )
                  ])
            : tripInfoRetreived != null
                ? GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(MapPage.routeName);
                    },
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          FlipCard(),
                          Text(
                            "تتبع رحلتك",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(fontWeight: FontWeight.bold)
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                    ),
                  )
                : RideSearching();
  }
}

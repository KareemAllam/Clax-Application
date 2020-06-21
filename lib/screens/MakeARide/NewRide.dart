// Dart & Other Packages
import 'dart:io';
import 'package:clax/models/Error.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// Flutter Material Components
import 'package:flutter/material.dart';
// Models
import 'package:clax/models/Line.dart';
import 'package:clax/models/Station.dart';
import 'package:clax/models/CurrentTrip.dart';
// Providers
import 'package:clax/providers/Payment.dart';
import 'package:clax/providers/CurrentTrip.dart';
// Screens
import 'package:clax/screens/MakeARide/widgets/FromCard.dart';
import 'package:clax/screens/Payments/Payment_HomeScreen.dart';
// Components
import 'package:clax/screens/MakeARide/Components/PickUpInfo.dart';
import 'package:clax/screens/MakeARide/Components/SeatsAndConfirm.dart';
import 'package:clax/screens/MakeARide/Components/PickUpLocationCards.dart';
// Widgets
import 'package:clax/screens/MakeARide/widgets/LineInfo.dart';
import 'package:clax/screens/MakeARide/widgets/SearchLine.dart';
// Drawer
import 'package:clax/screens/Drawer.dart';
// Static Data
import 'package:clax/appMap.dart';

class StartARide extends StatefulWidget {
  static const routeName = '/startARide';
  @override
  _StartARideState createState() => _StartARideState();
}

class _StartARideState extends State<StartARide> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // Theme Data
  ThemeData theme;
  // Payment Related
  double balance;
  // Searching Vars
  List<LineModel> _originalLines = [];
  List<LineModel> _searchLines = [];
  // Selection Vars
  LineModel originalLine;
  LineModel finalLine;
  int direction = 0;
  // PickUp Location
  Map<String, dynamic> pickuplocation = Map();
  // Animation Var
  bool loading = false;

  void setPickUpLodation(String name, LatLng coords, IconData icon) {
    setState(() {
      pickuplocation = {"name": name, "coords": coords, 'icon': icon};
    });
  }

  @override
  void initState() {
    super.initState();
    _originalLines = kiroMap();
    _searchLines = _originalLines;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
    balance = Provider.of<PaymentProvider>(context).balance;
  }

  void searchLines(String start) {
    if (start == '')
      setState(() {
        _searchLines = _originalLines;
      });
    else
      setState(() {
        _searchLines = _originalLines
            .where((element) => element.from.contains(start))
            .toList();
      });
  }

  // User Doesn't have enough money
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
          style:
              TextStyle(color: theme.accentColor, fontWeight: FontWeight.bold)),
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
              style: theme.textTheme.bodyText1
                  .copyWith(fontWeight: FontWeight.values[5]),
            ),
            SizedBox(height: 2),
            Text("يمكن شحن رصيدك في اي وقت عبر الانترنت.",
                style: theme.textTheme.caption)
          ],
        ),
      ),
      buttonPadding: EdgeInsets.all(0),
      actionsPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(0),
      content: Container(
          color: theme.primaryColor,
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

  // When user Selects a Line
  void selectLine(LineModel line) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (balance < line.cost.toDouble())
          noEnoughMoneyDB();
        else {
          FocusScope.of(context).unfocus();
          setState(() {
            originalLine = line;
            finalLine = line;
          });
        }
      }
    } on SocketException catch (_) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("تعذر الوصول للإنترنت")));
    }
  }

  // Swap Line Direction
  void swapDirection() {
    setState(() {
      finalLine = LineModel(
          id: finalLine.id,
          cost: finalLine.cost,
          from: finalLine.to,
          stations: finalLine.stations,
          to: finalLine.from);
      if (finalLine.from == originalLine.from)
        direction = 0;
      else
        direction = 1;
    });
  }

  // Clear Line Selection State
  void clearLine() {
    setState(() {
      finalLine = null;
      pickuplocation = Map();
    });
  }

  // Clear Pickup Location State
  void clearPickUpLocation() {
    setState(() {
      pickuplocation = Map();
    });
  }

  // Start Searchinf for driver
  void searchForDriver(int seats, double finalCost, bool onlinePayment) async {
    setState(() {
      loading = true;
    });
    StationModel firstStation = finalLine.stations.first;
    StationModel lastStation = finalLine.stations.last;
    LatLng start;
    LatLng end;
    if (direction == 0) {
      start = LatLng.fromJson(firstStation.coordinates);
      end = LatLng.fromJson(lastStation.coordinates);
    } else {
      start = LatLng.fromJson(lastStation.coordinates);
      end = LatLng.fromJson(firstStation.coordinates);
    }
    CurrentTrip trip = CurrentTrip(
        finalLine.id,
        '${finalLine.from} ${finalLine.to}',
        start,
        end,
        pickuplocation['coords'],
        seats,
        finalCost,
        onlinePayment);
    ServerResponse result =
        await Provider.of<CurrentTripProvider>(context, listen: false)
            .searchingDriverState(trip, direction, end);
    clearLine();
    setState(() {
      loading = false;
    });
    if (!result.status) {
      if (result.message.startsWith("لا"))
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              title: Text(result.message,
                  style: Theme.of(context).textTheme.bodyText1)),
        );
      else
        Scaffold.of(_scaffoldKey.currentContext).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("تعذر الوصول للخادم. حاول مره اخرى في وقت لاحق",
              strutStyle: StrutStyle(forceStrutHeight: true),
              style: TextStyle(fontFamily: 'Cairo')),
        ));
      // Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: _scaffoldKey,
        elevation: 0.0,
        title: Text('رحلة جديدة',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white)),
      ),
      drawer: MainDrawer(),
      body: loading
          ? Center(child: SpinKitCircle(color: Theme.of(context).primaryColor))
          : balance == null
              ? SpinKitCircle(color: theme.primaryColor)
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    finalLine == null
                        ? Container(
                            color: theme.scaffoldBackgroundColor,
                            padding: EdgeInsets.only(
                                bottom: 10, left: 10, right: 10, top: 15),
                            child: SearchLine(searchLines),
                          )
                        : LineInfo(finalLine, swapDirection, clearLine),
                    finalLine == null
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: _searchLines.length,
                              itemExtent: 80,
                              physics: AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              itemBuilder: (context, index) => FromCard(
                                line: _searchLines[index],
                                onTap: selectLine,
                              ),
                            ),
                          )
                        : pickuplocation['name'] == null
                            ? PickUpLocation(
                                line: finalLine,
                                setPickUpLodation: setPickUpLodation,
                              )
                            : Expanded(
                                child: Column(
                                  children: <Widget>[
                                    PickupInfo(
                                        pickuplocation, clearPickUpLocation),
                                    SeatsAndConfirm(balance, finalLine.cost,
                                        searchForDriver),
                                  ],
                                ),
                              )
                  ],
                ),
    );
  }
}

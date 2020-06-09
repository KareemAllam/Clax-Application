// Dart & Other Packages
import 'dart:io';
import 'package:provider/provider.dart';
// Flutter Material Components
import 'package:flutter/material.dart';
// Models
import 'package:clax/models/Line.dart';
import 'package:clax/models/Station.dart';
// Providers
import 'package:clax/providers/Payment.dart';
import 'package:clax/providers/CurrentTrip.dart';
// Screens
import 'package:clax/screens/MakeARide/RideSeats.dart';
import 'package:clax/screens/MakeARide/widgets/LineCard.dart';
import 'package:clax/screens/MakeARide/widgets/StationCard.dart';
import 'package:clax/screens/Payments/Payment_HomeScreen.dart';
// Static Data
import 'package:clax/appMap.dart';

class PickLocation extends StatefulWidget {
  @override
  _PickLocationState createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  ThemeData theme;
  TextEditingController _controllerPlace = new TextEditingController();
  LineModel selectedLine;
  List<LineModel> lines;
  List<LineModel> searchResult = [];

  void searchStation(String station) {
    if (station == '')
      setState(() {
        searchResult = lines;
      });
    else
      setState(() {
        searchResult =
            lines.where((element) => element.from.contains(station)).toList();
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

  // When user Selects a LineModel
  void selectLine(LineModel station) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        double balance =
            Provider.of<PaymentProvider>(context, listen: false).balance;
        if (balance < station.cost.toDouble())
          noEnoughMoneyDB();
        else {
          FocusScope.of(context).unfocus();
          setState(() {
            selectedLine = station;
          });
        }
      }
    } on SocketException catch (_) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text("تعذر الوصول للإنترنت")));
    }
  }

  void selectStation(StationModel dropoffLocation) {
    // Setting Selected Trip Info
    InternetAddress.lookup("www.google.com");
    // Station and PricePerSeat
    Map<String, dynamic> _tripInfo = {
      "lindId": selectedLine.id,
      "station": dropoffLocation.toJson(),
      "pricePerSeat": selectedLine.cost
    };
    Provider.of<CurrentTripProvider>(context, listen: false)
        .setTripInfo(_tripInfo);

    // Navigate to Info Screen
    Navigator.of(context).pushNamed(StartARide.routeName, arguments: {
      "line": {
        "from": selectedLine.from,
        "to": selectedLine.to,
        "lineId": selectedLine.id,
        "cost": selectedLine.cost
      },
      "destination": {
        "name": dropoffLocation.name,
        "coordinate": dropoffLocation.coordinates,
      },
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controllerPlace.dispose();
  }

  @override
  void initState() {
    super.initState();
    lines = getStaticData();
    searchResult = lines;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
  }

  dynamic position(int index) {
    if (index == 0)
      return false;
    else if (index == selectedLine.stations.length - 1)
      return true;
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return selectedLine == null
        // User Is Picking Station
        ? Column(
            mainAxisSize: MainAxisSize.max,
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: Colors.white,
                  child: TextField(
                    scrollPadding: EdgeInsets.all(0),
                    maxLines: 1,
                    controller: _controllerPlace,
                    onChanged: (value) => searchStation(value),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      counterText: '',
                      filled: true,
                      fillColor: Colors.black12,
                      contentPadding: EdgeInsets.all(0),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      focusedBorder: OutlineInputBorder(
                          gapPadding: 0,
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0),
                          borderRadius: BorderRadius.circular(30)),
                      enabledBorder: OutlineInputBorder(
                          gapPadding: 0,
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0),
                          borderRadius: BorderRadius.circular(30)),
                      border: OutlineInputBorder(
                          gapPadding: 0,
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0),
                          borderRadius: BorderRadius.circular(30)),
                      hintText: 'ابحث عن محطه',
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      suffixIcon: _controllerPlace.text != ""
                          ? IconButton(
                              icon: const Icon(Icons.cancel),
                              onPressed: () {
                                searchResult = lines;
                                _controllerPlace.clear();
                                setState(() {});
                              },
                            )
                          : SizedBox(),
                    ),
                  ),
                ),
                Expanded(
                    child: searchResult.length == 0
                        ? Center(
                            child: Text(
                            "قم باختيار المحطه المناسبة لك",
                            style: TextStyle(color: Colors.grey),
                          ))
                        : ListView.builder(
                            itemCount: lines.length,
                            itemExtent: 80,
                            physics: AlwaysScrollableScrollPhysics(
                                parent: BouncingScrollPhysics()),
                            itemBuilder: (context, index) => LineCard(
                                  line: lines[index],
                                  onTap: selectLine,
                                ))
                    // User Is Picking LineModel

                    )
              ])
        // User Is Picking Station
        : Column(
            mainAxisSize: MainAxisSize.max,
            // verticalDirection: VerticalDirection.up,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 10),
                  padding:
                      EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(Icons.linear_scale, color: theme.primaryColor),
                          SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '${selectedLine.from} - ${selectedLine.to}',
                                strutStyle: StrutStyle(forceStrutHeight: true),
                                style: theme.textTheme.headline6.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                              SizedBox(height: 12),
                              Text(
                                "من محافظة الى محافظة",
                                style: theme.textTheme.subtitle2
                                    .copyWith(color: Colors.grey),
                                strutStyle: StrutStyle(forceStrutHeight: true),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.black54,
                          ),
                          onPressed: () {
                            setState(() {
                              selectedLine = null;
                            });
                          })
                    ],
                  )),
              Expanded(
                child: ListView.builder(
                    itemCount: selectedLine.stations.length,
                    itemExtent: 50,
                    physics: AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    itemBuilder: (context, index) => StationCard(
                          position: position(index),
                          station: selectedLine.stations[index],
                          onSelect: selectStation,
                        )),
              )
            ],
          );
  }
}

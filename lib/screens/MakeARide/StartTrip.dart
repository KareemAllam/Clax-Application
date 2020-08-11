// Dart & Other Pacakges
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
// Flutter's Material Compoenents
import 'package:flutter/material.dart';
// Providers
// import 'package:clax/providers/Tracking.dart';
import 'package:clax/providers/RideSettings.dart';
// Models
import 'package:clax/models/Car.dart';
import 'package:clax/models/Line.dart';
// Screens
import 'package:clax/screens/MakeARide/Working.dart';

class StartTrip extends StatefulWidget {
  static const routeName = '/StartTrip';
  final Function changeWorkingState;
  StartTrip(this.changeWorkingState);
  @override
  _StartTripState createState() => _StartTripState();
}

class _StartTripState extends State<StartTrip> {
  Car selectedCar;
  LineModel selectedLine;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedCar =
        Provider.of<TripSettingsProvider>(context, listen: false).currentCar;
    selectedLine =
        Provider.of<TripSettingsProvider>(context, listen: false).currnetLine;
  }

  @override
  Widget build(BuildContext context) {
    List<Car> cars =
        Provider.of<TripSettingsProvider>(context, listen: false).driverCars;
    List<LineModel> lines =
        Provider.of<TripSettingsProvider>(context, listen: false).driverLines;

    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 16),
        // الخط
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text("الخط الحالي",
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 8),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButton<LineModel>(
              isExpanded: true,
              underline: SizedBox(),
              elevation: 0,
              value: selectedLine,
              selectedItemBuilder: (context) => lines
                  .map(
                    (element) => DropdownMenuItem(
                      child: Container(
                        width: width - width * 0.2,
                        color: Colors.white,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(Icons.linear_scale,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  SizedBox(width: 8),
                                  Text("الخط: ",
                                      style: TextStyle(color: Colors.grey)),
                                  Text(
                                    '${element.start.name} ${element.end.name}',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                element.cost.toString(),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Product Sans'),
                              )
                            ]),
                      ),
                      value: element,
                    ),
                  )
                  .toList(),
              items: lines
                  .map(
                    (element) => DropdownMenuItem(
                      child: Container(
                        color: Colors.white,
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(Icons.directions_bus,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  SizedBox(width: 8),
                                  Text("الخط: ",
                                      style: TextStyle(color: Colors.grey)),
                                  Text(
                                    '${element.start.name} ${element.end.name}',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                element.cost.toString(),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Product Sans'),
                              )
                            ]),
                      ),
                      value: element,
                    ),
                  )
                  .toList(),
              onChanged: (line) {
                setState(() => selectedLine = line);
              },
            ),
          )
        ]),
        // DivLine
        SizedBox(height: 16),
        // السياره
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text("السياره المستخدمه",
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 8),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButton<Car>(
              isExpanded: true,
              underline: SizedBox(),
              elevation: 0,
              value: selectedCar,
              selectedItemBuilder: (context) => cars
                  .map(
                    (element) => DropdownMenuItem(
                      child: Container(
                        width: width - width * 0.2,
                        color: Colors.white,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(Icons.directions_bus,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  SizedBox(width: 8),
                                  Text("اللوحه: ",
                                      style: TextStyle(color: Colors.grey)),
                                  Text(
                                    element.plateNumber,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Product Sans'),
                                  ),
                                ],
                              ),
                              Text(element.color,
                                  style: TextStyle(color: Colors.grey))
                            ]),
                      ),
                      value: element,
                    ),
                  )
                  .toList(),
              items: cars
                  .map(
                    (element) => DropdownMenuItem(
                      child: Container(
                        color: Colors.white,
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(Icons.directions_bus,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  SizedBox(width: 8),
                                  Text("اللوحه: ",
                                      style: TextStyle(color: Colors.grey)),
                                  Text(
                                    element.plateNumber,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Product Sans'),
                                  ),
                                ],
                              ),
                              Text(element.color,
                                  style: TextStyle(color: Colors.grey))
                            ]),
                      ),
                      value: element,
                    ),
                  )
                  .toList(),
              onChanged: (car) {
                setState(() => selectedCar = car);
              },
            ),
          )
        ]),
        Spacer(), // Ok Button
        Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () async {
                // Retrieveing Selected Line
                Provider.of<TripSettingsProvider>(context, listen: false)
                    .currentCar = selectedCar;
                Provider.of<TripSettingsProvider>(context, listen: false)
                    .currnetLine = selectedLine;

                // Checking Current Internet Status
                try {
                  final result = await InternetAddress.lookup('google.com');
                  // No Internet issues occured
                  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                    // Check if Driver is near the line
                    Geolocator _geolocator = Geolocator();
                    Position currnetLocation =
                        await _geolocator.getCurrentPosition();
                    if (await _geolocator.distanceBetween(
                                selectedLine.start.coordinates[0],
                                selectedLine.start.coordinates[0],
                                currnetLocation.latitude,
                                currnetLocation.longitude) >
                            30000 &&
                        await _geolocator.distanceBetween(
                                selectedLine.end.coordinates[0],
                                selectedLine.end.coordinates[0],
                                currnetLocation.latitude,
                                currnetLocation.longitude) >
                            30000) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "عفواً، انت لست قريب من هذا الخط",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      );
                    } else
                      Navigator.of(context).pushNamed(Working.routeName,
                          arguments: {
                            "lineName":
                                '${selectedLine.start.name} - ${selectedLine.end.name}'
                          });
                  }
                } on SocketException catch (_) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "تأكد من اتصالك بالانترنت و حاول مره اخرى",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  );
                }
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 12),
                color: Theme.of(context).primaryColor,
                child: Text(
                  "انطلق",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                widget.changeWorkingState(false);
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 12),
                color: Colors.red,
                child: Text(
                  "استراحه",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ])
      ],
    );
  }
}

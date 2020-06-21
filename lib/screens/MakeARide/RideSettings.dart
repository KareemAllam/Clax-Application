// Dart & Other Pacakges
import 'package:clax/models/Line.dart';
import 'package:clax/providers/Tracking.dart';
import 'package:provider/provider.dart';
// Flutter's Material Compoenents
import 'package:flutter/material.dart';
// Providers
import 'package:clax/providers/RideSettings.dart';
// Models
import 'package:clax/models/Car.dart';

class RideSettings extends StatefulWidget {
  static const routeName = '/rideSettings';
  @override
  _RideSettingsState createState() => _RideSettingsState();
}

class _RideSettingsState extends State<RideSettings> {
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('اعدادات الرحلة',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 16),
          // الخط
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
              Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("الخط الحالي:",
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
                                          color:
                                              Theme.of(context).primaryColor),
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
                                          color:
                                              Theme.of(context).primaryColor),
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
          SizedBox(height: 8),
          Divider(),
          // السياره
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
              Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("السياره المستخدمه: ",
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
                                          color:
                                              Theme.of(context).primaryColor),
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
                                          color:
                                              Theme.of(context).primaryColor),
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
          // Ok Button
          Spacer(flex: 2),
          Center(
            child: RaisedButton(
              elevation: 0,
              highlightElevation: 0,
              onPressed: () {
                Provider.of<TrackingProvider>(context, listen: false)
                    .disableStreamingCurrentLocation();
                Provider.of<TripSettingsProvider>(context, listen: false)
                    .currentCar = selectedCar;
                Provider.of<TripSettingsProvider>(context, listen: false)
                    .currnetLine = selectedLine;
                Provider.of<TrackingProvider>(context, listen: false)
                    .enableStreamingCurrentLocation();
                Navigator.of(context).pop();
              },
              child: Text(
                "حفظ",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

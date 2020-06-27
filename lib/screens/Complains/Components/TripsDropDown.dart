// Dart & Other Packages
import 'dart:core';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;
// Flutter's Material Components
import 'package:flutter/material.dart';
// Providers
import 'package:clax/providers/Trips.dart';
// Models
import 'package:clax/models/Trip.dart';

class TripsDropDownMenu extends StatefulWidget {
  final Function changeOriginal;
  final Function clearOriginal;
  final String placeholder;
  TripsDropDownMenu(this.changeOriginal, this.clearOriginal, this.placeholder);
  State createState() => TripsDropDownMenuState();
}

class TripsDropDownMenuState extends State<TripsDropDownMenu> {
  Trip selectedTrip;
  @override
  Widget build(BuildContext context) {
    List<Trip> trips = [];
    trips = Provider.of<TripsProvider>(context).trips;

    return trips == null
        ? Center(child: SpinKitCircle(color: Theme.of(context).primaryColor))
        : Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  width: 0.5,
                  color: Theme.of(context).secondaryHeaderColor,
                  style: BorderStyle.solid),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Icon(
                  Icons.directions_transit,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: DropdownButton<Trip>(
                      elevation: 3,
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: Theme.of(context).secondaryHeaderColor),
                      hint: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          widget.placeholder,
                          strutStyle: StrutStyle(forceStrutHeight: true),
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: widget.placeholder.contains("فضلك")
                                  ? Colors.red
                                  : Colors.grey),
                        ),
                      ),
                      value: selectedTrip,
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down),
                      underline: SizedBox(
                        height: 1,
                      ),
                      selectedItemBuilder: (BuildContext context) {
                        return trips.map<Widget>((Trip trip) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(trip.lineName,
                                  strutStyle:
                                      StrutStyle(forceStrutHeight: true),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w700)),
                              Spacer(flex: 2),
                              Text(
                                  intl.DateFormat('EEE')
                                      .add_jm()
                                      .format(trip.date),
                                  strutStyle:
                                      StrutStyle(forceStrutHeight: true),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                          fontFamily: 'Product Sans',
                                          color: Colors.grey))
                            ],
                          );
                        }).toList();
                      },
                      onChanged: (Trip value) {
                        widget.changeOriginal(value);
                        setState(() {
                          selectedTrip = value;
                        });
                      },
                      items: trips != null
                          ? trips.map((trip) {
                              return DropdownMenuItem<Trip>(
                                value: trip,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(trip.lineName,
                                        strutStyle:
                                            StrutStyle(forceStrutHeight: true),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            .copyWith(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w700)),
                                    Spacer(flex: 2),
                                    Text(
                                        intl.DateFormat('EEE')
                                            .add_jm()
                                            .format(trip.date),
                                        strutStyle:
                                            StrutStyle(forceStrutHeight: true),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(
                                                fontFamily: 'Product Sans',
                                                color: Colors.grey))
                                  ],
                                ),
                              );
                            }).toList()
                          : <DropdownMenuItem<Trip>>[
                              DropdownMenuItem(
                                  child: Container(
                                      child: Text("جاري التحميل ...")))
                            ]),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  iconSize: 18,
                  color: Colors.red,
                  padding: EdgeInsets.all(0),
                  constraints: const BoxConstraints(
                    minWidth: 22,
                    minHeight: kMinInteractiveDimension,
                  ),
                  onPressed: widget.clearOriginal,
                  alignment: Alignment.centerLeft,
                ),
              ],
            ),
          );
  }
}

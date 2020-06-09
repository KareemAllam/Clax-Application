// Dart & Other Packages
import 'dart:core';
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

  TripsDropDownMenu(this.changeOriginal);
  State createState() => TripsDropDownMenuState();
}

class TripsDropDownMenuState extends State<TripsDropDownMenu> {
  Trip selectedUser;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    List<Trip> trips = [];
    trips = Provider.of<TripsProvider>(context).trips;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
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
          SizedBox(width: width * 0.05),
          Expanded(
            flex: 2,
            child: DropdownButton<Trip>(
                elevation: 3,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Theme.of(context).secondaryHeaderColor),
                hint: Text("اختار الرحلة المناسبة",
                    style: Theme.of(context).textTheme.bodyText2),
                value: selectedUser,
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down),
                underline: SizedBox(
                  height: 1,
                ),
                onChanged: (Trip value) {
                  widget.changeOriginal(value);
                  setState(() {
                    selectedUser = value;
                  });
                },
                items: trips != null
                    ? trips.map((trip) {
                        return DropdownMenuItem<Trip>(
                          value: trip,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(trip.station.name,
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
                                      .format(trip.start),
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
                        DropdownMenuItem(child: Container(child: Text("Empty")))
                      ]),
          ),
        ],
      ),
    );
  }
}

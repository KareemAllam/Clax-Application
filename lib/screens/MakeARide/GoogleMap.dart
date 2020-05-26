import 'dart:ui';
import 'package:clax/providers/Map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget {
  static const routeName = "map";
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  MapProvider map;

  @override
  void dispose() {
    super.dispose();
    map.disableStreamingDriverLocation();
  }

  Widget build(BuildContext context) {
    map = Provider.of<MapProvider>(context);
    map.setScaffoldKey = _scaffoldKey;
    if (map.streamingLocation != null) map.enableStreamingDriverLocation();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.gps_fixed),
              onPressed: () async {
                try {
                  map.focusDriver = false;
                  await map.currentLocation();
                } catch (_) {
                  await map.currentLocation();
                }
              }),
          IconButton(
              icon: Icon(
                Icons.directions_bus,
                color: Colors.white,
              ),
              onPressed: () {
                map.enableStreamingDriverLocation();
              })
        ],
        title: Text(
          "اختر موقعك",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              circles: map.circles,
              minMaxZoomPreference: MinMaxZoomPreference(7, 25),
              polylines: map.polylines,
              markers: map.markers.values.toSet(),
              mapType: MapType.normal,
              compassEnabled: true,
              zoomGesturesEnabled: true,
              onCameraMove: null,
              initialCameraPosition: CameraPosition(
                  target: map.markedLocation['position'], zoom: 12),
              onMapCreated: (GoogleMapController controller) {
                if (!map.controller.isCompleted)
                  map.controller.complete(controller);
              },
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    map.markedLocation['name'],
                    textAlign: TextAlign.center,
                    strutStyle: StrutStyle(forceStrutHeight: true),
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                        color: Colors.white, fontFamily: "Product Sans"),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

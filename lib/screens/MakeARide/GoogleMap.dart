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
    map.disableStreamingDriverLocation();
    map.init();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    map = Provider.of<MapProvider>(context);
    map.setScaffoldKey = _scaffoldKey;
    map.setDriverId = 'driver123';
    if (!map.isListeningToDriver()) map.enableStreamingDriverLocation();
  }

  void showInfo() {
    TextTheme textTheme = Theme.of(context).textTheme;
    // Color accentColor = Theme.of(context).accentColor;
    // set up the button
    Widget okButton = FlatButton(
      child: Text("حسنا", style: TextStyle(color: Colors.black54)),
      onPressed: Navigator.of(context).pop,
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text("عذرب"),
      contentPadding: EdgeInsets.only(top: 20, right: 15, bottom: 20),
      content:
          Text("من فضلك، فعل نظام الملاحه خاصتك", style: textTheme.bodyText2),
      actions: [
        okButton,
      ],
    );

    // show the sheet
    showBottomSheet(
        context: _scaffoldKey.currentState.context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    map.checkGPSEnabled();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.gps_fixed),
              onPressed: () async {
                try {
                  map.focusDriver = false;
                  await map.currentLocation();
                } catch (_) {
                  await map.currentLocation();
                }
              }),
          IconButton(
              icon: const Icon(
                Icons.directions_bus,
                color: Colors.white,
              ),
              onPressed: () {
                map.focusDriver = true;
              }),
          Builder(
            builder: (context) => IconButton(
                icon: const Icon(
                  Icons.info,
                  color: Colors.white,
                ),
                onPressed: showInfo),
          )
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
              scrollGesturesEnabled: false,
              tiltGesturesEnabled: false,
              cameraTargetBounds: CameraTargetBounds(LatLngBounds(
                  southwest: LatLng(25.78847, 25.00192),
                  northeast: LatLng(40.78847, 40.00192))),
              circles: map.circles,
              minMaxZoomPreference: MinMaxZoomPreference(7, 25),
              polylines: map.polylines,
              markers: map.markers.values.toSet(),
              mapType: MapType.normal,
              compassEnabled: true,
              zoomGesturesEnabled: true,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              mapToolbarEnabled: false,
              indoorViewEnabled: false,
              onCameraMove: null,
              initialCameraPosition: CameraPosition(
                  target: map.markedLocation['position'], zoom: 12),
              onMapCreated: (GoogleMapController controller) {
                controller.setMapStyle(
                    '[  {    "featureType": "administrative.land_parcel",    "elementType": "labels",    "stylers": [      {        "visibility": "off"      }    ]  },  {    "featureType": "poi",    "elementType": "labels.text",    "stylers": [      {        "visibility": "off"      }    ]  },  {    "featureType": "poi.business",    "stylers": [      {        "visibility": "off"      }    ]  },  {    "featureType": "road",    "elementType": "labels.icon",    "stylers": [      {        "visibility": "off"      }    ]  },  {    "featureType": "road.local",    "elementType": "labels",    "stylers": [      {        "visibility": "off"      }    ]  },  {    "featureType": "transit",    "stylers": [      {        "visibility": "off"      }    ]  }]');
                if (!map.controller.isCompleted)
                  map.controller.complete(controller);
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Theme.of(context).primaryColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: map.gpsEnabled
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        textDirection: TextDirection.ltr,
                        children: <Widget>[
                          Text(
                            map.markedLocation['name'],
                            textAlign: TextAlign.center,
                            strutStyle: StrutStyle(forceStrutHeight: true),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    color: Colors.white,
                                    fontFamily: "Product Sans"),
                          ),
                          Text(
                            '${map.distance}',
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.ltr,
                            strutStyle: StrutStyle(forceStrutHeight: true),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    color: Colors.white,
                                    fontFamily: "Product Sans"),
                          )
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.location_on,
                              color: Colors.white, size: 20),
                          SizedBox(width: 10),
                          Text(
                            "فعل نظام الملاحه الخاص بك",
                            textAlign: TextAlign.center,
                            strutStyle: StrutStyle(forceStrutHeight: true),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(color: Colors.white),
                          )
                        ],
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

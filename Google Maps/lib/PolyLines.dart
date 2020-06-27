// Material Components
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_utils/poly_utils.dart';
import 'package:googlemap/Utils/MapConversions.dart';
// import 'package:google_maps_webservice/directions.dart';
import 'package:googlemap/kiro.dart';
// Google APi
// import 'package:google_maps_webservice/directions.dart';
// import 'package:google_maps_webservice/distance.dart';
// import 'package:google_maps_webservice/geocoding.dart';
// import 'package:google_maps_webservice/geolocation.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:google_maps_webservice/timezone.dart';

class TestMapPolyline extends StatefulWidget {
  @override
  _TestMapPolylineState createState() => _TestMapPolylineState();
}

class _TestMapPolylineState extends State<TestMapPolyline> {
  final Set<Marker> _markers = Set();
  final Set<Polyline> _polylines = Set();
  GoogleMapController controller;
  List<Point<num>> _polyLine = [];

  LatLng line = LatLng.fromJson([13.035607, 77.562381]);
  List<LatLng> latlngSegment1 = List();
  List<LatLng> latlngSegment2 = List();
  static LatLng _lat1 = LatLng(13.035606, 77.562381);
  static LatLng _lat2 = LatLng(13.070632, 77.693071);
  static LatLng _lat3 = LatLng(12.970387, 77.693621);
  static LatLng _lat4 = LatLng(12.858433, 77.575691);
  static LatLng _lat5 = LatLng(12.948029, 77.472936);
  static LatLng _lat6 = LatLng(13.069280, 77.455844);
  LatLng _lastMapPosition = _lat1;

  @override
  void initState() {
    super.initState();
    //line segment 1
    latlngSegment1.add(_lat1);
    latlngSegment1.add(_lat2);
    latlngSegment1.add(_lat3);
    latlngSegment1.add(_lat4);

    //line segment 2
    latlngSegment2.add(_lat4);
    latlngSegment2.add(_lat5);
    latlngSegment2.add(_lat6);
    latlngSegment2.add(_lat1);
  }

// getPolyLine
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Maps Testing"), actions: [
        IconButton(
            icon: Icon(Icons.map),
            onPressed: () async {
              LatLng _origin = LatLng(30.969721, 31.239449);
              LatLng _destination = LatLng(30.795822, 31.016610);

              List<LatLng> waypoints = [];
              // waypoints = [
              //   LatLng(30.969324, 31.211702),
              //   LatLng(30.959697, 31.142786),
              //   LatLng(30.880436, 31.082362)
              // ];

              _polyLine = await getLinePoints(_origin, _destination,
                  waypoints: waypoints);

              List<LatLng> polylinePoints =
                  MapConversions.stringPointToLatLngs(_polyLine);

              setState(() {
                _polylines.add(Polyline(
                  polylineId: PolylineId('dynamic'),
                  visible: true,
                  startCap: Cap.roundCap,
                  geodesic: true,
                  jointType: JointType.round,
                  endCap: Cap.roundCap,
                  points: polylinePoints,
                  width: 2,
                  color: Colors.purple,
                ));

                controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      zoom: 22,
                      target: LatLng(30.969721, 31.239449),
                    ),
                  ),
                );
              });
            })
      ]),
      body: GoogleMap(
        polylines: _polylines,
        markers: _markers,
        onTap: (LatLng value) {
          _markers.add(
              Marker(visible: true, markerId: MarkerId("w"), position: value));
          controller
              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            zoom: 22,
            target: value,
          )));
          setState(() {});

          Point<num> point = Point(value.latitude, value.longitude);
          print(
              PolyUtils.isLocationOnPathTolerance(point, _polyLine, false, 4));
        },
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _lastMapPosition,
          zoom: 11.0,
        ),
        mapType: MapType.normal,
      ),
    );
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        //_lastMapPosition is any coordinate which should be your default
        //position when map opens up
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Awesome Polyline tutorial',
          snippet: 'This is a snippet',
        ),
      ));

      _polylines.add(Polyline(
        polylineId: PolylineId('line1'),
        visible: true,
        //latlng is List<LatLng>
        points: latlngSegment1,
        width: 2,
        color: Colors.blue,
      ));

      // Different sections of polyline can have different colors
      _polylines.add(Polyline(
        polylineId: PolylineId('line2'),
        visible: true,
        //latlng is List<LatLng>
        points: latlngSegment2,
        width: 2,
        color: Colors.red,
      ));
    });
  }
}

// Material Components
import 'dart:math';
import 'package:clax/models/Station.dart';
import 'package:clax/services/GoogleApi.dart';
import 'package:clax/utils/MapConversions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_utils/poly_utils.dart';
// Google APi
// import 'package:google_maps_webservice/directions.dart';
// import 'package:google_maps_webservice/distance.dart';
// import 'package:google_maps_webservice/geocoding.dart';
// import 'package:google_maps_webservice/geolocation.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:google_maps_webservice/timezone.dart';

class MapPickLocation extends StatefulWidget {
  static const routeName = 'mapPickLocation';
  @override
  _MapPickLocationState createState() => _MapPickLocationState();
}

class _MapPickLocationState extends State<MapPickLocation> {
  // Map Vars
  GoogleMapController controller;
  Set<Marker> _markers = Set();
  Set<Polyline> _polylines = Set();
  // Selected Route Polyline
  List<Point<num>> _polyLine = [];
  // Route Settings
  LatLng start;
  LatLng end;
  List<StationModel> stations;
  // Timing Vars
  bool routeDrawin = false;
  bool locating = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Map<String, dynamic> arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    start = arguments["start"];
    end = arguments["end"];
    stations = arguments['stations'];
  }

  Future createPolyLine() async {
    try {
      List<LatLng> waypoints = [];
      // stations.forEach((element) =>
      //     waypoints.add(LatLng(element.coordinates[0], element.coordinates[1])));
      Map result = await getLinePoints(start, end, waypoints: waypoints);
      if (!result['status']) return;
      _polyLine = result['polyline'];
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
        routeDrawin = true;
        controller.getZoomLevel().then((zoomLevel) => controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(target: start, zoom: zoomLevel),
              ),
            ));
      });
    } catch (_) {
      print("Couldn't Fetch Data");
      print(_);
    }
  }

  Future userTap(LatLng value, BuildContext context) async {
    // Drawing Marker
    _markers.add(Marker(
        visible: true, markerId: MarkerId("userLocation"), position: value));
    // Animating to Marker

    controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: value, zoom: await controller.getZoomLevel()),
      ),
    );
    setState(() {});

    // Check if Point is near the line
    Point<num> point = Point(value.latitude, value.longitude);
    bool validlocation =
        PolyUtils.isLocationOnPathTolerance(point, _polyLine, false, 10);

    if (validlocation) {
      Placemark placemark = (await Geolocator().placemarkFromCoordinates(
          value.latitude, value.latitude,
          localeIdentifier: "ar_AE"))[0];

      Navigator.of(context).pop({
        "name":
            "${placemark.subAdministrativeArea} - ${placemark.administrativeArea}",
        "location": value,
      });
    } else
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: Text(
            "هذا النقطه بعيده عن الخط. رجاءاً اختر نقطه قريبة.",
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Colors.white),
            strutStyle: StrutStyle(forceStrutHeight: true),
          ),
          duration: Duration(seconds: 1),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          title: Text('حدد مكان الركوب',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white)),
          actions: [
            IconButton(
                icon: locating
                    ? SpinKitCircle(color: Colors.white, size: 24)
                    : Icon(Icons.gps_fixed),
                onPressed: locating
                    ? () {}
                    : () async {
                        setState(() {
                          locating = true;
                        });

                        Position currentPosition = await Geolocator()
                            .getCurrentPosition(
                                desiredAccuracy: LocationAccuracy.medium);

                        _markers.add(Marker(
                            markerId: MarkerId("currnetLocation"),
                            position: LatLng(currentPosition.latitude,
                                currentPosition.longitude)));

                        setState(() {
                          locating = false;
                        });

                        controller.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              zoom: await controller.getZoomLevel(),
                              target: LatLng(currentPosition.latitude,
                                  currentPosition.longitude),
                            ),
                          ),
                        );
                      })
          ]),
      body: Builder(
          builder: (context2) => GoogleMap(
                polylines: _polylines,
                markers: _markers,
                onTap:
                    !routeDrawin ? (_) {} : (value) => userTap(value, context2),
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: start,
                  zoom: 20.0,
                ),
                mapType: MapType.normal,
              )),
    );
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
      createPolyLine();
    });
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:googlemap/RealtimeDB.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMap extends ChangeNotifier {
  CustomMap({GlobalKey<ScaffoldState> scaffoldKey, double inZoom = 8}) {
    checkPermission();
    checkGPSEnabled();
    _markers = {};
    _polylines = Set();
    zooming = inZoom;
    _realtimeDB = RealtimeDB();
    _scaffoldKey = scaffoldKey;
  }
  // Scaffold Key
  GlobalKey<ScaffoldState> _scaffoldKey;
  // Permissions
  GeolocationStatus _permission;
  bool _gpsEnabled = false;
  // Map Controller
  Completer<GoogleMapController> _controller = Completer();
  // DriverMarker ID
  String _markerId = "driver";
  // Camera Options
  double zooming;
  // Dynamic Location Testing
  StreamSubscription<Position> streamingLocation;

  // Map Markers & Polylines
  Map<String, Marker> _markers;
  Set<Polyline> _polylines;
  // Initializing Realtime Database Connection
  RealtimeDB _realtimeDB;

  Future<bool> checkPermission() async {
    _permission = await Geolocator().checkGeolocationPermissionStatus();
    if (_permission == GeolocationStatus.granted) return true;
    return false;
  }

  Future<bool> checkGPSEnabled() async {
    _gpsEnabled = await Geolocator().isLocationServiceEnabled();
    return _gpsEnabled;
  }

  void enableStreamingCurrentLocation(String child, int seats, Function cb) {
    if (_gpsEnabled) {
      // Retreive current location updates
      var geolocator = Geolocator();
      var locationOptions =
          LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
      streamingLocation = geolocator
          .getPositionStream(locationOptions)
          .listen((Position position) async {
        // Update Database with current location updates
        _realtimeDB.setMainNode(child, position, seats);

        // Update the only marker
        Marker marker = Marker(
          markerId: MarkerId(_markerId),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(
            title: "Dynamic Movement",
            snippet: "Lat: ${position.latitude}, Long: ${position.longitude}",
          ),
        );
        _markers[_markerId] = marker;

        // Updating Map's current view
        CameraPosition currentMarker = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: zooming,
        );
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(currentMarker));

        // Updating Googlemap Widget
        cb();
      });
      // Show error Snackbar
    } else
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("برجاء تشغيل خدمة تحديد الموقع"),
      ));
  }

  void disableStreamingCurrentLocation() {
    streamingLocation.cancel();
  }

  void enableStreamingDriverLocation(String child, Function cb) {
    // Reading database changes of Location
    _realtimeDB.readAsync(child, (value) async {
      try {
        LatLng position =
            LatLng.fromJson([value['latitude'], value['longitude']]);
        Marker marker = Marker(
          markerId: MarkerId(_markerId),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(
            title: "Dynamic Movement",
            snippet: "Lat: ${position.latitude}, Long: ${position.longitude}",
          ),
        );
        _markers[_markerId] = marker;

        // Updating Map's current view
        CameraPosition currentMarker = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: zooming,
        );
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(currentMarker));

        // Updating Googlemap Widget
        cb();
      } catch (error) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("حدث خطأ ما"),
        ));
      }
    });
  }

  void disableStreamingDriverLocation(String child) {
    _realtimeDB.cancelReadAsync(child);
  }

  Set<Polyline> get polylines => _polylines;
  Map<String, Marker> get markers => _markers;
  Completer<GoogleMapController> get controller => _controller;
}

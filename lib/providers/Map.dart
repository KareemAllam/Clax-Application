import 'dart:async';
import 'package:clax/commonUI.dart';
import 'package:clax/services/RealtimeDB.dart';
import 'package:flutter/material.dart';
// import 'package:googlemap/RealtimeDB.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMap extends ChangeNotifier {
  CustomMap() {
    init();
  }
  // Scaffold Key
  GlobalKey<ScaffoldState> _scaffoldKey;
  // Permissions
  GeolocationStatus _permission;
  bool _gpsEnabled = false;
  // Map Controller
  Completer<GoogleMapController> _controller = Completer();
  Map<String, dynamic> _markedLocation;
  bool _focusDriver = true;
  // Markers ID
  String _userId;
  String _driverId;
  // Camera Options
  double zooming;
  // Dynamic Location Testing
  StreamSubscription<Position> streamingLocation;
  Geolocator _geolocator;
  // Map Markers & Polylines
  Map<String, Marker> _markers;
  Set<Circle> _circles;
  Set<Polyline> _polylines;
  // Initializing Realtime Database Connection
  RealtimeDB _realtimeDB;

  void init() async {
    _markers = {};
    _polylines = Set();
    _circles = Set();
    _userId = 'user';
    _driverId = "driver";

    zooming = 16;
    _markedLocation = {"name": "...loading name", "position": LatLng(30, 30)};
    _realtimeDB = RealtimeDB();
    _geolocator = Geolocator();
    await checkPermission();
    await checkGPSEnabled();
    if (_permission == GeolocationStatus.granted && _gpsEnabled)
      await currentLocation();
    notifyListeners();
  }

  Future checkPermission() async {
    GeolocationStatus result =
        await _geolocator.checkGeolocationPermissionStatus();

    if (result == GeolocationStatus.denied) {
      await _geolocator.getCurrentPosition();
    }
    _permission = result;
    await currentLocation();
  }

  Future checkGPSEnabled() async {
    _gpsEnabled = await Geolocator().isLocationServiceEnabled();
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
        // _realtimeDB.setMainNode(child, position, seats);

        // Update the only marker
        Marker marker = Marker(
          markerId: MarkerId(_userId),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(
            title: "Dynamic Movement",
            snippet: "Lat: ${position.latitude}, Long: ${position.longitude}",
          ),
        );
        _markers[_userId] = marker;

        // Updating Map's current view
        if (_focusDriver) {
          CameraPosition currentMarker = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: zooming,
          );
          final GoogleMapController controller = await _controller.future;
          controller
              .animateCamera(CameraUpdate.newCameraPosition(currentMarker));
        }
        notifyListeners();
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

  void enableStreamingDriverLocation() {
    // Reading Database changes of Location
    _realtimeDB.readAsync(_driverId, (value) async {
      try {
        // Parse Location from Database
        LatLng position =
            LatLng.fromJson([value['latitude'], value['longitude']]);
        Marker marker = Marker(
          markerId: MarkerId(_driverId),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(
            title: "Dynamic Movement",
            snippet: "Lat: ${position.latitude}, Long: ${position.longitude}",
          ),
        );
        _markers[_driverId] = marker;

        // Updating Map's current view
        CameraPosition currentMarker = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: zooming,
        );
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(currentMarker));

        notifyListeners();
      } catch (error) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("حدث خطأ ما"),
        ));
      }
    });
  }

  void disableStreamingDriverLocation() {
    _realtimeDB.cancelReadAsync(_driverId);
  }

  Future currentLocation() async {
    // Retreive current location updates
    if (_permission == GeolocationStatus.granted && _gpsEnabled) {
      Position position = await _geolocator.getCurrentPosition();
      _markedLocation["position"] =
          LatLng(position.latitude, position.longitude);

      // Retrieve Info about current location
      List<Placemark> placemark = await _geolocator.placemarkFromCoordinates(
          position.latitude, position.longitude);
      // Update global variable
      _markedLocation["name"] = placemark[0].administrativeArea +
          "," +
          placemark[0].subAdministrativeArea;
      // Update Camera's Current Location Circle
      circles.add(Circle(
        circleId: CircleId(_userId),
        fillColor: appTheme.primaryColor,
        strokeColor: appTheme.primaryColor.withAlpha(100),
        zIndex: 2,
        center: LatLng(position.latitude, position.longitude),
        radius: 20,
      ));
      // Updating Map's current view
      CameraPosition currentMarker = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 16,
      );
      final GoogleMapController controller = await _controller.future;
      try {
        controller.animateCamera(CameraUpdate.newCameraPosition(currentMarker));
      } catch (_) {
        print(_);
      }
      notifyListeners();
    }
  }

  set setScaffoldKey(GlobalKey<ScaffoldState> scaffoldkey) {
    _scaffoldKey = scaffoldkey;
  }

  Map<String, dynamic> get markedLocation => _markedLocation;
  StreamSubscription<Position> get locationStreaming => streamingLocation;
  Set<Polyline> get polylines => _polylines;
  Set<Circle> get circles => _circles;
  Map<String, Marker> get markers => _markers;
  Completer<GoogleMapController> get controller => _controller;
  set controller(controller) => _controller = controller;
  set setDriverId(id) => _driverId = id;
  set focusDriver(boolean) => _focusDriver = boolean;
}

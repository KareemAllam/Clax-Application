// FLutter MaterialComponenets
import 'package:clax/providers/CurrentTrip.dart';
import 'package:clax/screens/MakeARide/RateTrip.dart';
import 'package:flutter/material.dart';
// Dart & Other Packages
import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Services
import 'package:clax/services/RealtimeDB.dart';
// Application Theme
import 'package:clax/commonUI.dart';

class MapProvider extends ChangeNotifier {
  MapProvider() {
    init();
  }
  // Scaffold Key
  GlobalKey<ScaffoldState> _scaffoldKey;
  // Permissions
  GeolocationStatus _permission;
  bool _gpsEnabled = false;
  // Map Controller
  Completer<GoogleMapController> _controller;
  Map<String, dynamic> _userLocation;
  bool _focusDriver;
  // Markers ID
  String _userId;
  String _driverId;
  String _lineId;
  // Camera Options
  double zooming;
  // Dynamic Location Testing
  StreamSubscription<Position> streamingLocation;
  Geolocator _geolocator;
  // Map Markers & Polylines
  Map<String, Marker> _markers;
  Set<Circle> _circles;
  Set<Polyline> _polylines;
  String distance;
  // Initializing Realtime Database Connection
  RealtimeDB _realtimeDB;
  // Trip has Ended?
  bool ended;

  Future init() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _controller = Completer();
    _markers = {};
    _polylines = Set();
    _circles = Set();
    _userId = 'user';
    _driverId = "driver";
    _focusDriver = true;
    ended = false;
    zooming = 16;
    distance = 'calculating...';
    // If previous distance was saved
    if (_prefs.getString("currentLocaiton") != null) {
      Map<String, dynamic> decoded = Map<String, dynamic>.from(
          json.decode(_prefs.getString("currentLocaiton")));
      _userLocation = {
        "name": decoded['name'],
        "position": LatLng.fromJson(decoded['position'])
      };
    }
    // If no distance was saved before
    else
      _userLocation = {"name": "...loading name", "position": null};

    _realtimeDB = RealtimeDB();
    _geolocator = Geolocator();
    await checkPermission();
    _gpsEnabled = await Geolocator().isLocationServiceEnabled();
    if (_permission == GeolocationStatus.granted && _gpsEnabled)
      await currentLocation();

    notifyListeners();
  }

  Future disposeInit() async {
    _controller = Completer();
    // _markers = {};
    // _polylines = Set();
    // _circles = Set();
    // _realtimeDB = RealtimeDB();
  }

  void setDriverId(String driverId, String lineId) {
    _driverId = driverId;
    _lineId = lineId;
    notifyListeners();
    enableStreamingDriverLocation();
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
    notifyListeners();
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
        if (!_focusDriver) {
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

  bool isListeningToDriver() {
    try {
      return _realtimeDB.dbRefs[_driverId] != null;
    } catch (_) {
      return false;
    }
  }

  void enableStreamingDriverLocation() {
    int i;
    ended = false;
    // Reading Database changes of Location
    // if (_realtimeDB == null) _realtimeDB = RealtimeDB();
    print('clax-lines/$_lineId/$_driverId');
    _realtimeDB.readAsync('clax-lines/$_lineId/$_driverId', (value) async {
      print("Got Value: $value");
      try {
        // Parse Location from Database
        LatLng position =
            LatLng.fromJson([value['loc']['lat'], value['loc']['lng']]);
        // Updating Driver's Marker
        _markers[_driverId] = Marker(
          markerId: MarkerId(_driverId),
          position: position,
          infoWindow: InfoWindow(
            title: "Driver",
            snippet: "Lat: ${position.latitude}, Long: ${position.longitude}",
          ),
        );
        // Update Distance
        if (_userLocation == null || _userLocation["position"] == null)
          await currentLocation();
        i = (await _geolocator.distanceBetween(
                _userLocation["position"].latitude,
                _userLocation["position"].longitude,
                position.latitude,
                position.longitude))
            .ceil();
        i > 999 ? distance = '${i / 1000} km' : distance = '$i m';
        if (i < 100) {
          i = 1000;
          ended = true;
          disableStreamingDriverLocation();
          driverArrived();
        }
        if (_controller.isCompleted) navigateToDriver();
        // Changing Required Values
        notifyListeners();
      } catch (error) {
        print("Error: $error");
        if (_scaffoldKey.currentState != null)
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("حدث خطأ ما"),
          ));
        // throw error;
      }
    });
  }

  void disableStreamingDriverLocation() {
    _realtimeDB.cancelReadAsync('clax-lines/$_lineId/$_driverId');
  }

  void navigateToDriver() async {
    // Animating Camera if app has focus on driver
    if (_focusDriver) {
      // Updating Map's current view
      CameraPosition currentMarker = CameraPosition(
        target: _markers[_driverId].position,
        zoom: zooming,
      );
      final GoogleMapController controller = await _controller.future;
      // controller.moveCamera(CameraUpdate.newCameraPosition(currentMarker));
      // Slower
      controller.animateCamera(CameraUpdate.newCameraPosition(currentMarker));
      notifyListeners();
    }
  }

  void navigateToUser() async {
    CameraPosition currentMarker = CameraPosition(
      target: _userLocation['position'],
      zoom: 16,
    );
    GoogleMapController controller = await _controller.future;
    // controller.moveCamera(CameraUpdate.newCameraPosition(currentMarker));
    // Slower
    controller.animateCamera(CameraUpdate.newCameraPosition(currentMarker));
  }

  Future currentLocation() async {
    if (!_gpsEnabled) {
      checkGPSEnabled();
      return;
    }
    // Retreive current location updates
    if (_permission == GeolocationStatus.granted && _gpsEnabled) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();

      // Using GPS to retrieve current location
      Position position = await _geolocator.getCurrentPosition();
      // Retrieve Info about current location
      List<Placemark> placemark = await _geolocator.placemarkFromCoordinates(
          position.latitude, position.longitude);

      //// Update global variable
      // Location Name
      _userLocation["name"] = placemark[0].administrativeArea +
          "," +
          placemark[0].subAdministrativeArea;
      // Location Coordinates
      _userLocation["position"] = LatLng(position.latitude, position.longitude);
      // Updating Cache
      _prefs.setString("currentLocaiton", json.encode(_userLocation));

      // Update Camera's Current Location Circle
      circles.add(Circle(
        circleId: CircleId(_userId),
        fillColor: appTheme.primaryColor,
        strokeColor: appTheme.primaryColor.withAlpha(100),
        zIndex: 2,
        center: LatLng(position.latitude, position.longitude),
        radius: 10,
      ));
      notifyListeners();
      // print(_userLocation['position']);
    }
  }

  void driverArrived() async {
    // Clear Trip state
    Provider.of<CurrentTripProvider>(_scaffoldKey.currentContext, listen: false)
        .clearTripInfo();

    // Setting up the button
    Widget continueButton = FlatButton(
      child: Text("حسنا",
          style: TextStyle(
              color: Theme.of(_scaffoldKey.currentContext).accentColor,
              fontWeight: FontWeight.bold)),
      onPressed: () {
        // Dismiss the Alert Dialoge Box
        Navigator.of(_scaffoldKey.currentContext)
            .pushReplacementNamed(RateTrip.routeName);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      title: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5))),
        padding: EdgeInsets.only(top: 20, right: 15, left: 15, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "لقد وصل السائق",
              style: Theme.of(_scaffoldKey.currentContext)
                  .textTheme
                  .bodyText1
                  .copyWith(fontWeight: FontWeight.values[5]),
            ),
            SizedBox(height: 2),
            Text("انتظر حتى انتهاء الرحلة ثم قم بتقيم السائق.",
                style: Theme.of(_scaffoldKey.currentContext).textTheme.caption)
          ],
        ),
      ),
      buttonPadding: EdgeInsets.all(0),
      actionsPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(0),
      content: Container(
        color: Theme.of(_scaffoldKey.currentContext).primaryColor,
        child: continueButton,
      ),
    );

    // show the dialog
    await showDialog(
      useRootNavigator: true,
      context: _scaffoldKey.currentContext,
      builder: (BuildContext context) {
        return alert;
      },
    ).then((value) => Navigator.of(_scaffoldKey.currentContext)
        .pushReplacementNamed(RateTrip.routeName));
  }

  // Getters
  LatLng get coordinates => _userLocation['position'];
  String get name => _userLocation['name'];
  StreamSubscription<Position> get locationStreaming => streamingLocation;
  Set<Polyline> get polylines => _polylines;
  Set<Circle> get circles => _circles;
  bool get driverIsFocused => _focusDriver;
  bool get gpsEnabled => _gpsEnabled;
  Map<String, Marker> get markers => _markers;
  Completer<GoogleMapController> get controller => _controller;

  // Setters
  set initController(_) => _controller = Completer();
  set controller(controller) => _controller = controller;
  set focusDriver(boolean) => _focusDriver = boolean;
  set setScaffoldKey(GlobalKey<ScaffoldState> sk) => _scaffoldKey = sk;
}

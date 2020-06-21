// Flutter's Material Component
import 'package:flutter/material.dart';
// Dart & Other Packages
import 'dart:math';
import 'dart:async';
import 'dart:typed_data';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// Services
import 'package:clax/services/GoogleApi.dart';
import 'package:clax/services/RealtimeDB.dart';
// Provider
import 'package:clax/providers/Auth.dart';
import 'package:clax/providers/Profile.dart';
import 'package:clax/providers/Payment.dart';
import 'package:clax/providers/RideSettings.dart';
// Models
import 'package:clax/models/Line.dart';
import 'package:clax/models/Bill.dart';
import 'package:clax/models/PassengerInfo.dart';
// Utils
import 'package:clax/utils/MapConversions.dart';

class TrackingProvider extends ChangeNotifier {
  // ----- Properties -----
  // Context
  GlobalKey<ScaffoldState> scaffoldKey;
  // Permissions
  GeolocationStatus permission;
  bool gpsEnabled;
  // Trackiong Vars
  GoogleMapController controller;
  Geolocator _geolocator = Geolocator();
  Map<String, Marker> markers = Map();
  Map<String, Polyline> polylines = Map();
  List<Point<num>> currentRoute = [];
  bool driverFocued = true;
  // Streamnig Vars
  StreamSubscription<Position> streamingLocation;
  RealtimeDB _realtimeDB = RealtimeDB();
  // Users Informations
  LatLng currentLocation;
  List<PassengerInfo> passengers = [];

  // ----- Constructores -----
  // Synchronous Constructor
  TrackingProvider() {
    if (streamingLocation == null) getCurrentLocation();
  }

  // ----- Functionality -----
  Future checkPermission() async {
    permission = await _geolocator.checkGeolocationPermissionStatus();
    notifyListeners();
  }

  Future checkGPSEnabled() async {
    gpsEnabled = await _geolocator.isLocationServiceEnabled();
    notifyListeners();
  }

  Future getCurrentLocation() async {
    permission = await _geolocator.checkGeolocationPermissionStatus();
    gpsEnabled = await _geolocator.isLocationServiceEnabled();
    notifyListeners();
  }

  void enableStreamingCurrentLocation() async {
    // Retreive current location updates
    Geolocator geolocator = Geolocator();
    LocationOptions locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    String fbToken =
        Provider.of<AuthProvider>(scaffoldKey.currentContext, listen: false)
            .fbToken;
    Uint8List icon = await getBytesFromAsset('assets/images/buss.png', 100);
    // Initalizing Passengers
    passengers = [];

    // Retrieve Direction
    int direction = 0;
    Position position = await geolocator.getCurrentPosition();
    direction = await isDriverNearStart(position.latitude, position.longitude);
    // Create New Payment
    startNewTripPayment(direction);
    // Draw Route
    drawRoute();
    notifyListeners();

    streamingLocation = geolocator.getPositionStream(locationOptions).listen(
      (Position position) {
        currentLocation = LatLng(position.latitude, position.longitude);
        // Update Database with current location updates
        int seats = Provider.of<TripSettingsProvider>(
                scaffoldKey.currentContext,
                listen: false)
            .currnetSeats;
        LineModel line = Provider.of<TripSettingsProvider>(
                scaffoldKey.currentContext,
                listen: false)
            .currnetLine;
        String id = Provider.of<ProfilesProvider>(scaffoldKey.currentContext,
                listen: false)
            .id;

        // Check if Driver Reached Destination
        // If it is going from `start` to `end`
        List<double> coords;
        direction == 0
            ? coords = line.end.coordinates
            : coords = line.start.coordinates;
        geolocator
            .distanceBetween(
                position.latitude, position.longitude, coords[0], coords[1])
            .then((value) {
          if (value < 1000) {
            disableStreamingCurrentLocation();
            notifyListeners();
          }
        });

        // Position position, int seats
        _realtimeDB.setMainNode('clax-lines/${line.id}/$id', {
          "loc": {"lat": position.latitude, "lng": position.longitude},
          "seats": seats,
          "direction": direction,
          "fireBaseId": fbToken
        });

        // Update the only marker
        Marker marker = Marker(
          markerId: MarkerId('driver'),
          icon: BitmapDescriptor.fromBytes(icon),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(
            title: "Dynamic Movement",
            snippet: "Lat: ${position.latitude}, Long: ${position.longitude}",
          ),
        );
        markers['driver'] = marker;
        notifyListeners();
        if (driverFocued)
          controller.animateCamera(CameraUpdate.newLatLng(
              LatLng(position.latitude, position.longitude)));
      },
    );
  }

  void disableStreamingCurrentLocation() {
    if (streamingLocation != null) {
      streamingLocation.cancel();
      streamingLocation = null;

      LineModel line = Provider.of<TripSettingsProvider>(
              scaffoldKey.currentContext,
              listen: false)
          .currnetLine;
      String id = Provider.of<ProfilesProvider>(scaffoldKey.currentContext,
              listen: false)
          .id;
      _realtimeDB.deleteMainNode('clax-lines/${line.id}/$id');
    }
  }

  void addPassenger(PassengerInfo passenger) {
    passengers.add(passenger);
    String id = passengers.length.toString();
    markers[id] = Marker(
        markerId: MarkerId(id),
        position: passenger.locationCoords,
        visible: true);
    notifyListeners();
    controller.animateCamera(CameraUpdate.newLatLng(passenger.locationCoords));
    Provider.of<TripSettingsProvider>(scaffoldKey.currentContext, listen: false)
        .currnetSeats += passenger.seats;
  }

  void drawRoute() async {
    LineModel line = Provider.of<TripSettingsProvider>(
            scaffoldKey.currentContext,
            listen: false)
        .currnetLine;

    Map route = await getLinePoints(LatLng.fromJson(line.start.coordinates),
        LatLng.fromJson(line.end.coordinates));

    if (!route['status']) return;

    currentRoute = route['polyline'];
    List<LatLng> polylinePoints =
        MapConversions.stringPointToLatLngs(currentRoute);
    polylines['route'] = Polyline(
      polylineId: PolylineId('currentRoute'),
      visible: true,
      startCap: Cap.roundCap,
      geodesic: true,
      jointType: JointType.round,
      endCap: Cap.roundCap,
      points: polylinePoints,
      width: 2,
      color: Colors.purple,
    );
    notifyListeners();
    controller.animateCamera(
        CameraUpdate.newLatLng(LatLng.fromJson(line.start.coordinates)));
  }

  Future<int> isDriverNearStart(double driverLat, double driverLng) async {
    LatLng lineStart = LatLng.fromJson(Provider.of<TripSettingsProvider>(
            scaffoldKey.currentContext,
            listen: false)
        .currnetLine
        .start
        .coordinates);
    double distance = await _geolocator.distanceBetween(
        lineStart.latitude, lineStart.longitude, driverLat, driverLng);
    if (distance > 750)
      return 1;
    else
      return 0;
  }

  void startNewTripPayment(direction) {
    LineModel line = Provider.of<TripSettingsProvider>(
            scaffoldKey.currentContext,
            listen: false)
        .currnetLine;
    // Near Start
    String billTitle;
    // Driver is traveling from `start` to `end`
    direction == 0
        ? billTitle = '${line.start.name} - ${line.end.name}'
        : billTitle = '${line.end.name} - ${line.start.name}';
    Provider.of<PaymentProvider>(scaffoldKey.currentContext, listen: false)
        .startNewTrip(BillModel(
            name: billTitle,
            date: DateTime.now(),
            ppc: line.cost,
            totalSeats: 0));
  }

  Future navigatorToDriver() async {
    Position position = await Geolocator().getCurrentPosition();

    controller.animateCamera(CameraUpdate.newLatLng(
        LatLng.fromJson([position.latitude, position.longitude])));
  }
}

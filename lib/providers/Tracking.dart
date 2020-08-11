// Flutter's Material Component
import 'package:clax/screens/MakeARide/TripEnded.dart';
import 'package:flutter/material.dart';
// Dart & Other Packages
import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// Services
import 'package:clax/services/GoogleApi.dart';
import 'package:clax/services/RealtimeDB.dart';
import 'package:clax/services/Backend.dart';
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
// Widgets
import 'package:clax/screens/MakeARide/widgets/Alert.dart';

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
  String tourId;
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
    if (streamingLocation == null) checkServiceState();
  }

  // ----- Functionality -----
  Future checkPermission() async {
    permission = await _geolocator.checkGeolocationPermissionStatus();
    notifyListeners();
  }

  Future<bool> checkGPSEnabled() async {
    return await _geolocator.isLocationServiceEnabled();
  }

  Future checkServiceState() async {
    await _geolocator.getCurrentPosition();
    permission = await _geolocator.checkGeolocationPermissionStatus();
    gpsEnabled = await _geolocator.isLocationServiceEnabled();
    notifyListeners();
  }

  void enableStreamingCurrentLocation() async {
    // Initializations
    // Current Firebase Token
    String fbToken =
        Provider.of<AuthProvider>(scaffoldKey.currentContext, listen: false)
            .fbToken;
    // Map Icon
    Uint8List icon = await getBytesFromAsset('assets/images/buss.png', 100);
    // Initalizing Passengers
    passengers = [];
    // Geolocation Accuracy Options
    Geolocator geolocator = Geolocator();
    LocationOptions locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    // Currnet Line
    LineModel line = Provider.of<TripSettingsProvider>(
            scaffoldKey.currentContext,
            listen: false)
        .currnetLine;
    // Retrieve Direction
    int direction = 0;
    Position position = await geolocator.getCurrentPosition();
    direction = await isDriverNearStart(position.latitude, position.longitude);
    // Retreiving TourID
    Map body = {
      "lineId": line.id,
      "seats": Provider.of<TripSettingsProvider>(scaffoldKey.currentContext,
              listen: false)
          .currnetSeats,
      "loc": {"lat": position.latitude, "lng": position.longitude},
      "direction": direction
    };
    Response result = await Api.post(
        'drivers/settings/start-tour', json.encode(body),
        stringDynamic: true);
    if (result.statusCode == 200) {
      tourId = json.decode(result.body);
      // end tour data
      // Create New Payment
      startNewTripPayment(direction);
      // Draw Route on Map
      await drawRoute();

      // Check if Driver Reached Destination
      // If it is going from `start` to `end`
      List<double> coords;
      direction == 0
          ? coords = line.end.coordinates
          : coords = line.start.coordinates;
      if (direction == 0)
        print('${line.start.name} => ${line.end.name}');
      else
        print('${line.end.name} => ${line.start.name}');

      //---------------------------
      // Boradcasting Tour Information
      streamingLocation = geolocator.getPositionStream(locationOptions).listen(
        (Position position) {
          currentLocation = LatLng(position.latitude, position.longitude);

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

          // Update Database with current location updates
          int seats = Provider.of<TripSettingsProvider>(
                  scaffoldKey.currentContext,
                  listen: false)
              .currnetSeats;

          // Check if Driver Reached destination
          geolocator
              .distanceBetween(
                  position.latitude, position.longitude, coords[0], coords[1])
              .then((value) {
            // print(value);
            // Driver reached the end of the Line
            if (value < 1500) {
              Api.post(
                'drivers/settings/end-tour',
                {"lineId": line.id, "tourId": tourId},
              );
              print('driver arrived');
              disableStreamingCurrentLocation();
              Navigator.of(scaffoldKey.currentContext)
                  .pushNamed(TripEnded.routeName);
            }
          });

          // Position position, int seats
          _realtimeDB.setMainNode('clax-lines/${line.id}/$tourId', {
            "loc": {"lat": position.latitude, "lng": position.longitude},
            "seats": seats,
            "direction": direction,
            "fireBaseId": fbToken
          });

          // if (direction == 0) {
          //   geolocator
          //       .distanceBetween(position.latitude, position.longitude,
          //           line.end.coordinates[0], line.end.coordinates[1])
          //       .then((double distancee) {
          //     if (distancee < 1000) disableStreamingCurrentLocation();
          //     Api.post('drivers/settings/end-tour', bodyData);
          //   });
          // } else {
          //   geolocator
          //       .distanceBetween(position.latitude, position.longitude,
          //           line.end.coordinates[0], line.end.coordinates[1])
          //       .then((double distancee) {
          //     if (distancee < 1000) disableStreamingCurrentLocation();
          //     Api.post('drivers/settings/end-tour', bodyData);
          //   });
          // }
        },
      );
    } else
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "تاكد من اتصالك بالانترنت و حاول مره اخرى",
            style: Theme.of(scaffoldKey.currentContext)
                .textTheme
                .bodyText2
                .copyWith(color: Colors.white),
            strutStyle: StrutStyle(forceStrutHeight: true),
          ),
        ),
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
      Provider.of<TripSettingsProvider>(scaffoldKey.currentContext,
              listen: false)
          .working = false;
      Provider.of<PaymentProvider>(scaffoldKey.currentContext, listen: false)
          .endTrip();
    }
  }

  void addPassenger(PassengerInfo passenger) {
    passengers.add(passenger);
    String id = passenger.requestId;
    markers[id] = Marker(
        markerId: MarkerId(id),
        position: passenger.locationCoords,
        visible: true);
    notifyListeners();
    controller.animateCamera(CameraUpdate.newLatLng(passenger.locationCoords));
    Provider.of<TripSettingsProvider>(scaffoldKey.currentContext, listen: false)
        .currnetSeats += passenger.seats;
  }

  /// Remove a passenger using his coordiantes
  /// , converted to String,
  /// as a String
  /// E. g. passenger.locationCoords.toString();
  void removePassenger(String requestId) {
    markers[requestId] = null;
    passengers.removeWhere((element) => element.requestId == requestId);
    notifyListeners();
  }

  Future drawRoute() async {
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
            lineName: billTitle,
            date: DateTime.now(),
            cost: line.cost,
            seats: 0));
  }

  void trackPassengerRequest(lineId, requestId, message) {
    // Track Request from Realtime DB
    _realtimeDB.readAsync("clax-requests/$lineId/$requestId", (value) async {
      if (value == null)
        _realtimeDB.cancelReadAsync("clax-requests/$lineId/$requestId");

      // If user has cancelled the trip
      if (value['status'] == "cancel" || value['status'] == "canceled") {
        // Retreive Location
        List<double> coords =
            List<double>.from(json.decode(message['data']['station_location']));
        // Show Notification to Driver
        showSimpleNotification(Text("عذراً، قام الراكب بالغاء الطلب"));
        removePassenger(LatLng.fromJson(coords).toString());
        // Stop Reading
        _realtimeDB.cancelReadAsync("clax-requests/$lineId/$requestId");
      }

      // If user has confirmed the trip
      else if (value['status'] == "waiting") {
        // Show Notification to Driver
        showSimpleNotification(Text("الراكب ينتظرك على الطريق"));
        // Retreive Location
        List<double> coords =
            List<double>.from(json.decode(message['data']['station_location']));
        // Add Passenger to
        addPassenger(PassengerInfo(
          message['data']['station_name'],
          LatLng.fromJson(coords),
          int.parse(message['data']['seats']),
          requestId,
        ));
      }

      // If user has cancelled the trip after pairing
      else if (value['status'] == "passenger_cancelled") {
        // Stop Reading
        _realtimeDB.cancelReadAsync("clax-requests/$lineId/$requestId");
        Provider.of<PaymentProvider>(scaffoldKey.currentContext, listen: false)
            .updateCurrentTrip(int.parse(message['data']['seats']));
        // Show Notification to Driver
        showNotification(scaffoldKey.currentContext, "قام الراكب بإلغاء الطلب.",
            "تم اضافة سعر الرحلة لحسابك");
      }

      // If user has cancelled the trip after pairing
      else if (value['status'] == "done") {
        // Stop Reading
        _realtimeDB.cancelReadAsync("clax-requests/$lineId/$requestId");
        Provider.of<PaymentProvider>(scaffoldKey.currentContext, listen: false)
            .updateCurrentTrip(int.parse(message['data']['seats']));
        // Show Notification to Driver
        showNotification(scaffoldKey.currentContext, "صعد الراكب بنجاح",
            "تم اضافة ثمن الرحلة لحسابك. راجع حسابك بعد انتهاء الرحلة.",
            trailing: MaterialButton(
              onPressed: () {},
              color: Colors.green,
              textColor: Colors.white,
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(16),
              shape: CircleBorder(),
            ));
      }
    });
  }

  Future navigatorToDriver() async {
    Position position = await Geolocator().getCurrentPosition();

    controller.moveCamera(CameraUpdate.newLatLng(
        LatLng.fromJson([position.latitude, position.longitude])));
  }
}

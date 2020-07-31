// Dart & Other Packages
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:clax/screens/MakeARide/Clax.dart';
import 'package:clax/widgets/CustomCircleIndicator.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// FLutter MaterialComponenets
import 'package:flutter/material.dart';
// Models
import 'package:clax/models/Bill.dart';
// Utils
import 'package:clax/utils/MapConversions.dart';
// Services
import 'package:clax/services/GoogleApi.dart';
import 'package:clax/services/RealtimeDB.dart';
// Providers
import 'package:clax/providers/CurrentTrip.dart';
import 'package:clax/providers/Payment.dart';
// Components
import 'package:clax/screens/MakeARide/RateTrip.dart';
// Application Theme
import 'package:clax/commonUI.dart';

class MapProvider extends ChangeNotifier {
  MapProvider() {
    init();
  }
  // Scaffold Key
  GlobalKey<ScaffoldState> scaffoldKey;
  // Permissions
  GeolocationStatus _permission;
  bool _gpsEnabled = false;
  // Map Controller
  Completer<GoogleMapController> _controller;
  // State Vars

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
  // Initializing Realtime Database Connection
  RealtimeDB _realtimeDB;
  // Trip has Ended?
  bool ended;
  double distance;
  String timeString;
  String distanceString;
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
    distance = null;
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
    if (_realtimeDB == null) _realtimeDB = RealtimeDB();
    if (_geolocator == null) _geolocator = Geolocator();
    _gpsEnabled = await Geolocator().isLocationServiceEnabled();
    notifyListeners();
  }

  Future disposeInit() async {
    _controller = Completer();
    // _markers = {};
    // _polylines = Set();
    // _circles = Set();
    // _realtimeDB = RealtimeDB();
  }

  void setDriverId(
      String driverId, String lineId, LatLng pickupLocation) async {
    _driverId = driverId;
    _lineId = lineId;
    List<Placemark> placemarks = await _geolocator.placemarkFromCoordinates(
        pickupLocation.latitude, pickupLocation.longitude,
        localeIdentifier: "ar_AR");
    _userLocation["name"] = placemarks[0].subAdministrativeArea +
        " - " +
        placemarks[0].administrativeArea;
    _userLocation['position'] = pickupLocation;

    notifyListeners();
    enableStreamingDriverLocation();
  }

  Future checkPermission() async {
    if (_geolocator == null) _geolocator = Geolocator();
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
      scaffoldKey.currentState.showSnackBar(SnackBar(
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

  void enableStreamingDriverLocation() async {
    int i;
    ended = false;
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/images/buss.png', 100);
    // Reading Database changes of Location
    // if (_realtimeDB == null) _realtimeDB = RealtimeDB();
    print('clax-lines/$_lineId/$_driverId');
    if (_realtimeDB == null) _realtimeDB = RealtimeDB();
    _realtimeDB.readAsync('clax-lines/$_lineId/$_driverId', (value) async {
      try {
        // Parse Location from Database
        LatLng position =
            LatLng.fromJson([value['loc']['lat'], value['loc']['lng']]);
        // Updating Driver's Marker
        _markers[_driverId] = Marker(
          markerId: MarkerId(_driverId),
          position: position,
          flat: true,
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(
            title: "Driver",
            snippet: "Lat: ${position.latitude}, Long: ${position.longitude}",
          ),
        );

        // Retreive Distance Info
        Map distanceInfo =
            await getDuration(position, _userLocation["position"]);
        // Update Time
        timeString = distanceInfo["duration"]['text'];
        // Update Distance
        distance = distanceInfo['distance']['value'].toDouble();
        distanceString = distanceInfo['distance']['text'];
        i = distance.floor();
        if (i < 1000) {
          i = 10000;
          ended = true;
          disableStreamingDriverLocation();
          driverArrived();
        }
        if (_controller.isCompleted) navigateToDriver();
        // Changing Required Values
        notifyListeners();
      } catch (error) {
        print("Error: $error");
        if (scaffoldKey.currentState != null)
          scaffoldKey.currentState.showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "حدث خطأ ما",
              style: Theme.of(scaffoldKey.currentContext)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white),
              strutStyle: StrutStyle(forceStrutHeight: true),
            ),
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
      final GoogleMapController controller = await _controller.future;
      // Updating Map's current view
      CameraPosition currentMarker = CameraPosition(
        target: _markers[_driverId].position,
        zoom: await controller.getZoomLevel(),
      );
      // controller.moveCamera(CameraUpdate.newCameraPosition(currentMarker));
      // Slower
      controller.animateCamera(CameraUpdate.newCameraPosition(currentMarker));
      notifyListeners();
    }
  }

  void navigateToUser() async {
    GoogleMapController controller = await _controller.future;
    markers[_userId] = Marker(
        markerId: MarkerId(_userId), position: _userLocation['position']);
    notifyListeners();
    CameraPosition currentMarker = CameraPosition(
      target: _userLocation['position'],
      zoom: await controller.getZoomLevel(),
    );
    print(_userLocation['position']);
    // controller.moveCamera(CameraUpdate.newCameraPosition(currentMarker));
    // Slower
    controller.animateCamera(CameraUpdate.newCameraPosition(currentMarker));
  }

  Future currentLocation() async {
    if (!_gpsEnabled) {
      checkGPSEnabled();
      return;
    }
    if (_permission == null) {
      if (_geolocator == null) _geolocator = Geolocator();
      GeolocationStatus result =
          await _geolocator.checkGeolocationPermissionStatus();

      if (result == GeolocationStatus.denied) {
        await _geolocator.getCurrentPosition();
      }
      _permission = result;
    }
    // Retreive current location updates
    if (_permission == GeolocationStatus.granted && _gpsEnabled) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();

      // Using GPS to retrieve current location
      Position position = await _geolocator.getCurrentPosition();
      // Retrieve Info about current location
      List<Placemark> placemark = await _geolocator.placemarkFromCoordinates(
          position.latitude, position.longitude,
          localeIdentifier: "ar_AE");
      //// Update global variable
      // Location Name
      _userLocation["name"] = placemark[0].subAdministrativeArea +
          " - " +
          placemark[0].administrativeArea;
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
    }
    return _userLocation;
  }

  void driverArrived() async {
    String requestId = Provider.of<CurrentTripProvider>(
            scaffoldKey.currentContext,
            listen: false)
        .currentTripInfo
        .requestId;

    Timer time = Timer(Duration(seconds: 60), () {
      // Stop Trip State
      // Change request State
      _realtimeDB.updateChild('clax-requests/$_lineId/$requestId',
          {'status': "passenger_cancelled"});
      Navigator.of(scaffoldKey.currentContext).pop();
      // Clear Trip State
      Provider.of<CurrentTripProvider>(scaffoldKey.currentContext,
              listen: false)
          .clearTripInfo();

      // Return to Main Screen
      Navigator.of(scaffoldKey.currentContext).popUntil((route) {
        if (route.settings.name == Clax.routeName) return true;
        return false;
      });

      // Reduce Balance
      double finalPrice = Provider.of<CurrentTripProvider>(
              scaffoldKey.currentContext,
              listen: false)
          .currentTripInfo
          .finalCost;
      Provider.of<PaymentProvider>(scaffoldKey.currentContext, listen: false)
          .setBalance = -finalPrice;
      // Add Bill
      Provider.of<PaymentProvider>(scaffoldKey.currentContext, listen: false)
          .add(BillModel(
              amount: finalPrice,
              date: DateTime.now(),
              type: "Punishment",
              description: "عقوبة الغاء الرحلة"));
      // Stop Ongoing State
      disableStreamingDriverLocation();
      Provider.of<CurrentTripProvider>(scaffoldKey.currentContext,
              listen: false)
          .cancelTripRequest();
      showDialog(
        context: scaffoldKey.currentContext,
        builder: (context) => AlertDialog(
          elevation: 1,
          backgroundColor: Colors.transparent,
          title: GestureDetector(
            onTap: Navigator.of(scaffoldKey.currentContext).pop,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("لم تقم بالرد على السائق ف الوقت المناسب",
                        style: Theme.of(scaffoldKey.currentContext)
                            .textTheme
                            .bodyText1),
                    Text("تم خصم سعر الرحلة من حسابك.",
                        style: Theme.of(scaffoldKey.currentContext)
                            .textTheme
                            .bodyText2
                            .copyWith(color: Colors.grey)),
                  ]),
            ),
          ),
        ),
      );
    });

    // Setting up the button
    Widget continueButton = FlatButton(
      child: Text("ركبت",
          style: TextStyle(
              color: Theme.of(scaffoldKey.currentContext).accentColor,
              fontWeight: FontWeight.bold)),
      onPressed: () {
        // Stop the timer
        time.cancel();
        // Change request State
        _realtimeDB.updateChild(
            'clax-requests/$_lineId/$requestId', {'status': "done"});
        rateDriver();
      },
    );

    Widget cancelButton = FlatButton(
      child: Text("لم اجد السائق",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
      onPressed: () {
        // Stop the timer
        time.cancel();
        // Change request State
        LatLng userLocation = _userLocation['position'];
        _realtimeDB.updateChild('clax-requests/$_lineId/$requestId', {
          'status': "driver_cancelled",
          "passengerLoc": {
            "lat": userLocation.latitude,
            "lng": userLocation.longitude
          }
        });
        // Dismiss the Alert Dialoge Box
        Navigator.of(scaffoldKey.currentContext).pop();
        // Clear Trip State
        Provider.of<CurrentTripProvider>(scaffoldKey.currentContext,
                listen: false)
            .clearTripInfo();

        // Return to Main Screen
        Navigator.of(scaffoldKey.currentContext).popUntil((route) {
          if (route.settings.name == Clax.routeName) return true;
          return false;
        });
        showDialog(
          context: scaffoldKey.currentContext,
          builder: (context) => AlertDialog(
            elevation: 1,
            backgroundColor: Colors.transparent,
            title: GestureDetector(
              onTap: Navigator.of(scaffoldKey.currentContext).pop,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("نعتذر عن تصرف السائق",
                          style: Theme.of(scaffoldKey.currentContext)
                              .textTheme
                              .bodyText1),
                      Text(
                          "سيتم اضافه تعويض لحسابك في اسرع وقت بعد مراجعه المشكلة",
                          style: Theme.of(scaffoldKey.currentContext)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.grey)),
                    ]),
              ),
            ),
          ),
        );
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
              style: Theme.of(scaffoldKey.currentContext)
                  .textTheme
                  .bodyText1
                  .copyWith(fontWeight: FontWeight.values[5]),
            ),
            SizedBox(height: 2),
            Row(
              children: <Widget>[
                Text("انتظر حتى تركب المكروباص ثم اضغط ركبت.",
                    style:
                        Theme.of(scaffoldKey.currentContext).textTheme.caption),
                CustomCircleIndicator(60)
              ],
            ),
          ],
        ),
      ),
      buttonPadding: EdgeInsets.all(0),
      actionsPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(0),
      content: Container(
        color: Theme.of(scaffoldKey.currentContext).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            continueButton,
            cancelButton,
          ],
        ),
      ),
    );

    // show the dialog
    showDialog(
        barrierDismissible: false,
        context: scaffoldKey.currentContext,
        builder: (BuildContext context) {
          return alert;
        });
  }

  void rateDriver() async {
    // Setting up the button
    Widget continueButton = FlatButton(
      child: Text("حسنا",
          style: TextStyle(
              color: Theme.of(scaffoldKey.currentContext).accentColor,
              fontWeight: FontWeight.bold)),
      onPressed: () {
        // Dismiss the Alert Dialoge Box
        Navigator.of(scaffoldKey.currentContext)
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
              style: Theme.of(scaffoldKey.currentContext)
                  .textTheme
                  .bodyText1
                  .copyWith(fontWeight: FontWeight.values[5]),
            ),
            SizedBox(height: 2),
            Text("انتظر حتى انتهاء الرحلة ثم قم بتقيم السائق.",
                style: Theme.of(scaffoldKey.currentContext).textTheme.caption)
          ],
        ),
      ),
      buttonPadding: EdgeInsets.all(0),
      actionsPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(0),
      content: Container(
        color: Theme.of(scaffoldKey.currentContext).primaryColor,
        child: continueButton,
      ),
    );

    // show the dialog
    await showDialog(
      useRootNavigator: true,
      context: scaffoldKey.currentContext,
      builder: (BuildContext context) {
        return alert;
      },
    ).then((value) => Navigator.of(scaffoldKey.currentContext)
        .pushReplacementNamed(RateTrip.routeName));
  }

  void cancelOngoingTrip() {
    // Update Reqeust
    String requestId = Provider.of<CurrentTripProvider>(
            scaffoldKey.currentContext,
            listen: false)
        .currentTripInfo
        .requestId;
    _realtimeDB.updateChild(
        'clax-requests/$_lineId/$requestId', {'status': "passenger_cancelled"});
    // Reduce Balance
    double finalPrice = Provider.of<CurrentTripProvider>(
            scaffoldKey.currentContext,
            listen: false)
        .currentTripInfo
        .finalCost;
    Provider.of<PaymentProvider>(scaffoldKey.currentContext, listen: false)
        .setBalance = -finalPrice;
    // Add Bill
    Provider.of<PaymentProvider>(scaffoldKey.currentContext, listen: false).add(
        BillModel(
            amount: finalPrice,
            date: DateTime.now(),
            type: "Punishment",
            description: "عقوبة الغاء الرحلة"));
    // Stop Ongoing State
    disableStreamingDriverLocation();
    Provider.of<CurrentTripProvider>(scaffoldKey.currentContext, listen: false)
        .cancelTripRequest();
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
}

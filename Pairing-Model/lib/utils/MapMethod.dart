import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppState with ChangeNotifier {
  static LatLng _initialPosition ;
  LatLng _lastPosition = _initialPosition;
  bool locationServiceActive = true;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  GoogleMapController _mapController;
  //GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  TextEditingController _locationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  LatLng get initialPosition => _initialPosition;

  LatLng get lastPosition => _lastPosition;
  TextEditingController get  locationController => _locationController;

  // GoogleMapsServices get googleMapsServices => _googleMapsServices;

  GoogleMapController get mapController => _mapController;

  Set<Marker> get markers => _markers;

  Set<Polyline> get polyLines => _polyLines;

  AppState() {
    _getUserLocation();
    _loadingInitialPosition();
  }

// ! TO GET THE USERS LOCATION
  void _getUserLocation() async {
    print("GET USER METHOD RUNNING =========");
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);

    _initialPosition = LatLng(position.latitude, position.longitude);
    print(
        "the latitude is: ${position.longitude} and th longitude is: ${position.longitude} ");
    print("initial position is : ${_initialPosition.toString()}");

    _locationController.text = placemark[0].name + ","+ placemark[0].locality;
    print("${placemark}++++++++++++++++++++++");

    notifyListeners();
  }
  void get_address(LatLng position)async{
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);

    _locationController.text = placemark[0].name + ","+ placemark[0].locality;

    notifyListeners();
    ;
  }

  // ! TO CREATE ROUTE
  void createRoute(String encondedPoly) {
    _polyLines.add(Polyline(
        polylineId: PolylineId(encondedPoly),
        width: 10,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.black));
    notifyListeners();
  }

  // ! ADD A MARKER ON THE MAO
  void _addMarker(LatLng location, String address) {
    _markers.add(Marker(
        markerId: MarkerId(_lastPosition.toString()),
        position: location,
        infoWindow: InfoWindow(title: address, snippet: "go here"),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet)));
    notifyListeners();
  }

  // ! CREATE LAGLNG LIST
  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  // !DECODE POLY
  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
// repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negetive then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

/*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  // ! SEND REQUEST
  void sendRequest(String intendedLocation) async {
    List<Placemark> placemark =
        await Geolocator().placemarkFromAddress(intendedLocation);
    print('-------------place ${intendedLocation}');
    double latitude = placemark[0].position.latitude;
    double longitude = placemark[0].position.longitude;
//    GoogleMapPolyline googleMapPolyline = new GoogleMapPolyline(
//        apiKey: "AIzaSyB8cWSfSBqHRQBE1PFwb3A2VRO9vMT5qV4");
    print('reqlan ${latitude}');
    print('reqlon ${longitude}');
    LatLng destination = LatLng(latitude, longitude);
    _addMarker(destination, intendedLocation);
    // String route = await _googleMapsServices.getRouteCoordinates(
    //   _initialPosition, destination);
    createRoute(destination.toString());
    notifyListeners();
  }

  // ! ON CAMERA MOVE
  void onCameraMove(CameraPosition position) {
    _lastPosition = position.target;
    notifyListeners();
  }

  // ! ON CREATE
  void onCreated(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

//  LOADING INITIAL POSITION
  void _loadingInitialPosition() async {
    await Future.delayed(Duration(seconds: 5)).then((v) {
      if (_initialPosition == null) {
        locationServiceActive = false;
        notifyListeners();
      }
    });
  }
}

//void _fetchJobs() async {
//  var jobsListAPIUrl = Uri(port: 3000,
//      scheme: 'http',
//      host: '192.168.94.1',
//      path: "api/user/station/");
//  print("////////////////////////");
//  var response = await http.get(
//      jobsListAPIUrl
//  ).then((value) {
//      print('Sccessed...');
//      print(value);
//    });
//  //final response = await http.get('https://192.168.1.5:3000/api/user/station/');
//  print(response);
//
//
//}
//
//
//  void _send_post() async {
//    //  var send = {{'latitude': initialPosition.latitude}, {'longitude': initialPosition.longitude}};
//
//    var uri = Uri(port: 3000,
//        scheme: 'http',
//        host: '192.168.1.5',
//        path: "api/user/station/");
//    print("http${uri}");
//    await http.post(Uri.decodeFull((uri.toString())), body: {
//
//      "location": json.encode({"lat": initialPosition.latitude,
//        "long": initialPosition.longitude,
//
//      })
//    }).then((value) {
//      print('Sccessed...');
//      print(value);
//    });
//    print("HTTP HERE-------------------------------");
//  }
//
//
Future<void> _get_req() async {
  print("*****************************");
  var uri = Uri(
      port: 3000,
      scheme: 'http',
      host: '192.168.1.30',
      path: "api/user/station");
  print("http${uri}");
  final res = await http.get(uri);
  print("***************************${res.body}***********************");
}

//class GoogleMapsServices{
//  static const apiKey = "AIzaSyB8cWSfSBqHRQBE1PFwb3A2VRO9vMT5qV4";
//  Future<String> getRouteCoordinates(LatLng l1, LatLng l2)async{
//    String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
//    http.Response response = await http.get(url);
//    print(response);
//    Map values = jsonDecode(response.body);
//    print('/////////////////////////////////');
//    print( values["routes"][0]["overview_polyline"]["points"]);
//    return values["routes"][0]["overview_polyline"]["points"];
//  }
//}

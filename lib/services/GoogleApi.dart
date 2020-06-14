import 'dart:math';

import 'package:clax/utils/MapConversions.dart';
import 'package:google_maps_utils/poly_utils.dart';

import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as GoogleMaps;
import 'package:google_maps_webservice/distance.dart';

GoogleMapsDirections directionsApi =
    GoogleMapsDirections(apiKey: "AIzaSyBkN4KS6PmgIVOwS4p_ceT5SlYqyQ4AsmA");

GoogleDistanceMatrix distanceMatrixApi =
    GoogleDistanceMatrix(apiKey: "AIzaSyBkN4KS6PmgIVOwS4p_ceT5SlYqyQ4AsmA");

Future<Map> getLinePoints(
    GoogleMaps.LatLng origin, GoogleMaps.LatLng destination,
    {List<GoogleMaps.LatLng> waypoints}) async {
  // Send Reqeust to GoogleMaps API
  DirectionsResponse response = await directionsApi.directionsWithLocation(
    MapConversions.latlngToLocation(origin),
    MapConversions.latlngToLocation(destination),
    waypoints:
        waypoints == null ? [] : MapConversions.latlngToWaypoint(waypoints),
    departureTime: "now",
    trafficModel: TrafficModel.bestGuess,
    travelMode: TravelMode.driving,
    units: Unit.metric,
    alternatives: false,
  );
  // If not Internet Connection / Error Occured
  if (response.status != "OK") {
    return {"status": false};
  }

  // Get All Routes
  List<Route> _routes = response.routes;
  // We only care about the First Route
  // Get Route Data (Stringified)
  String pointsString = _routes[0].overviewPolyline.points;
  List<Point<num>> points = PolyUtils.decode(pointsString);
  return {"status": true, "polyline": points};
}

// Future routeInformation()async{
//   distanceMatrixApi.distanceWithLocation(origin, destination)
// }

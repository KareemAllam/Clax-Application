import 'dart:math';

import 'package:google_maps_utils/poly_utils.dart';
import 'package:googlemap/Utils/MapConversions.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as GoogleMaps;

GoogleMapsDirections directionsApi =
    GoogleMapsDirections(apiKey: "AIzaSyBkN4KS6PmgIVOwS4p_ceT5SlYqyQ4AsmA");

Future<List<Point<num>>> getLinePoints(
    GoogleMaps.LatLng origin, GoogleMaps.LatLng destination,
    {List<GoogleMaps.LatLng> waypoints}) async {
  // Send Reqeust to GoogleMaps API
  DirectionsResponse result = await directionsApi.directionsWithLocation(
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
  // Get All Routes
  List<Route> _routes = result.routes;
  // We only care about the First Route
  // Get Route Data (Stringified)
  String pointsString = _routes[0].overviewPolyline.points;
  List<Point<num>> points = PolyUtils.decode(pointsString);

  return points;
}

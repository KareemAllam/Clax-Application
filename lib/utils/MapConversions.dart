import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as GoogleMaps;
import 'package:google_maps_webservice/directions.dart' as GoogleDirections;

class MapConversions {
  static GoogleDirections.Location latlngToLocation(
      GoogleMaps.LatLng location) {
    return GoogleDirections.Location(location.latitude, location.longitude);
  }

  static List<GoogleDirections.Waypoint> latlngToWaypoint(
      List<GoogleMaps.LatLng> coordinates) {
    List<GoogleDirections.Waypoint> waypoints = [];
    coordinates.forEach((latlng) {
      waypoints.add(
          GoogleDirections.Waypoint.fromLocation(latlngToLocation(latlng)));
    });
    return waypoints;
  }

  // static
  static List<GoogleMaps.LatLng> stringPointToLatLngs(List<Point<num>> points) {
    List<GoogleMaps.LatLng> _latLngs = [];
    points.forEach((element) {
      _latLngs.add(GoogleMaps.LatLng(element.x, element.y));
    });
    return _latLngs;
  }
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
      .buffer
      .asUint8List();
}

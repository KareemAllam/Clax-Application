import 'package:google_maps_flutter/google_maps_flutter.dart';

class PassengerInfo {
  String requestId;
  String locationName;
  LatLng locationCoords;
  int seats;

  PassengerInfo(
      this.locationName, this.locationCoords, this.seats, this.requestId);

  PassengerInfo.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    locationName = json['station_name'];
    locationCoords = LatLng.fromJson(json['station_location']);
    seats = json['seats'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestId'] = this.requestId;
    data['station_name'] = this.locationName;
    data['seats'] = this.locationCoords.toJson();
    data['seats'] = this.seats;
    return data;
  }
}

import 'package:google_maps_flutter/google_maps_flutter.dart';

/// 1. *String* **lindId**
/// 2. *String* **Station**
/// 3. *String* **requestId**
/// 4. *LatLng* **pickupCoords**
/// 5. *double* **FinalCost**
/// 6. *int* **seats**
class CurrentTrip {
  // Line Info
  String lindId;
  String lineName;
  // Coordinates Info
  LatLng start;
  LatLng end;
  LatLng pickupCoords;
  // Trip Info
  int seats;
  double finalCost;
  // Request Info
  DateTime startDate;
  String requestId;

  CurrentTrip(this.lindId, this.lineName, this.start, this.end,
      this.pickupCoords, this.seats, this.finalCost,
      {this.requestId, this.startDate});

  CurrentTrip.fromJson(Map<String, dynamic> json) {
    // Required
    // Line Info
    lindId = json['lineId'];
    lineName = json['lineName'];
    // Coordinates
    start = LatLng.fromJson(json['start']);
    end = LatLng.fromJson(json['end']);
    pickupCoords = LatLng.fromJson(json['pickupCoords']);
    // Trip Info
    requestId = json['requestId'];
    seats = int.parse(json['seats']);
    finalCost = double.parse(json['finalCost']);
    // Not Required
    if (json['startDate'] != null)
      startDate = DateTime.parse(json['startDate']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // Line Info
    data['lineId'] = this.lindId;
    data['lineName'] = this.lineName;
    // Coordinates
    data['start'] = this.start.toJson();
    data['end'] = this.end.toJson();
    data['pickupCoords'] = this.pickupCoords.toJson();
    // Trip Info
    data['requestId'] = this.requestId;
    data['seats'] = this.seats.toString();
    data['finalCost'] = this.finalCost.toString();
    // Not Required
    if (this.startDate != null) data['startDate'] = this.startDate.toString();
    return data;
  }
}

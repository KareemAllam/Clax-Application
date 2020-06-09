// Dart
import 'dart:core';
// Models
import 'package:clax/models/Driver.dart';
import 'package:clax/models/Station.dart';

class Trip {
  String id;
  String lineId;
  StationModel station;
  DriverModel driver;
  DateTime start;
  double price;
  int rate;
  Trip(
      {this.id,
      this.start,
      this.lineId,
      this.driver,
      this.price,
      this.station,
      this.rate});

  Trip.fromJson(Map<String, dynamic> json) {
    id = json['_d'];
    start = DateTime.parse(json['start']) ?? DateTime.now();
    lineId = json['lineId'] ?? null;
    station = StationModel.fromJson(json['station']) ?? null;
    driver = json['driver'] != null
        ? new DriverModel.fromJson(json['driver'])
        : null;
    price = double.parse(json['price'].toString());
    rate = json['rate'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start'] = this.start.toString();
    data['lineId'] = this.lineId.toString();
    StationModel _station = this.station;
    data['station'] = _station.toJson();
    if (this.driver != null) {
      data['driver'] = this.driver.toJson();
    }
    data['price'] = this.price;
    data['rate'] = this.rate ?? "0";
    return data;
  }
}

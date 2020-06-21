// Dart
import 'dart:core';
// Models
import 'package:clax/models/Driver.dart';

class Trip {
  String id;
  String lineId;
  String lineName;
  DriverModel driver;
  DateTime startDate;
  double price;
  int rate;
  bool favorite;
  Trip(
      {this.id,
      this.startDate,
      this.lineId,
      this.driver,
      this.price,
      this.lineName,
      this.rate,
      this.favorite});

  Trip.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    startDate = DateTime.parse(json['start']) ?? DateTime.now();
    lineId = json['lineId'] ?? null;
    lineName = json['_line'] ?? null;
    driver = json['driver'] != null
        ? new DriverModel.fromJson(json['driver'])
        : null;
    price = json['price'].toDouble();
    rate = json['rate'] ?? 0;
    favorite = json['favorite'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lineId'] = this.lineId;
    data['lineName'] = this.lineName;
    data['start'] = this.startDate.toString();
    if (this.driver != null) {
      data['driver'] = this.driver.toJson();
    }
    data['price'] = this.price;
    data['rate'] = this.rate ?? 0;
    return data;
  }
}

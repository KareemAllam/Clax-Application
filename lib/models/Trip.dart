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
  Trip({
    this.id,
    this.startDate,
    this.lineId,
    this.price,
    this.lineName,
  });

  Trip.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    startDate = DateTime.parse(json['start']) ?? DateTime.now();
    lineId = json['lineId'] ?? null;
    lineName = json['lineName'] ?? null;
    price = double.parse(json['price'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['lineId'] = this.lineId;
    data['lineName'] = this.lineName;
    data['start'] = this.startDate.toString();
    data['price'] = this.price;
    return data;
  }
}

import 'dart:core';
import 'package:flutter_complete_guide/models/Driver.dart';
import 'package:flutter_complete_guide/models/Line.dart';

class Trip {
  String id;
  DateTime start;
  Line line;
  Driver driver;
  int price;

  Trip({this.id, this.start, this.line, this.driver, this.price});

  Trip.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    start = DateTime.parse(json['start']) ?? DateTime.now();
    line = json['_line'] != null ? new Line.fromJson(json['_line']) : null;
    driver =
        json['_driver'] != null ? new Driver.fromJson(json['_driver']) : null;
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['start'] = this.start.toString();
    if (this.line != null) {
      data['_line'] = this.line.toJson();
    }
    if (this.driver != null) {
      data['_driver'] = this.driver.toJson();
    }
    data['price'] = this.price;
    return data;
  }
}

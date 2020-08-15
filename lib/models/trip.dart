// Dart
import 'dart:core';

class Trip {
  String id;
  int rate;
  double cost;
  int seats;
  DateTime date;
  String lineName;

  // Optional
  Trip({
    this.id,
    this.date,
    this.seats,
    this.cost,
    this.lineName,
    this.rate = 0,
  });

  Trip.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    rate = json['rate'] ?? 0;
    cost = json['cost'].toDouble();
    seats = json['seats'];
    date = json['date'] == null ? DateTime.now() : DateTime.parse(json['date']);
    lineName = json['_line'] ?? null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lineName'] = this.lineName;
    data['start'] = this.date.toString();
    data['seats'] = this.seats;
    data['cost'] = this.cost;
    data['rate'] = this.rate ?? 0;
    return data;
  }
}

// Dart
import 'dart:core';
import 'dart:typed_data';

class Trip {
  String id;
  int rate;
  double cost;
  int seats;
  DateTime date;
  String lineName;
  String driverName;
  Uint8List driverPicture;

  // Optional
  Trip(
      {this.id,
      this.date,
      this.seats,
      this.cost,
      this.lineName,
      this.driverName,
      this.rate = 0,
      this.driverPicture});

  Trip.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    rate = json['rate'] ?? 0;
    cost = json['cost'].toDouble();
    seats = json['seats'];
    date = json['date'] == null ? DateTime.now() : DateTime.parse(json['date']);
    lineName = json['_line'] ?? null;
    driverName = json['driverName'] ?? '';
    driverPicture = json['driverPicture'] == null
        ? Uint8List(1)
        : Uint8List.fromList(json['driverPicture']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lineName'] = this.lineName;
    data['start'] = this.date.toString();
    data['seats'] = this.seats;
    data['cost'] = this.cost;
    data['rate'] = this.rate ?? 0;
    data['driverPicture'] = this.driverPicture ?? '';
    data['driverName'] = this.driverName ?? 'جاري التجميل';
    return data;
  }
}

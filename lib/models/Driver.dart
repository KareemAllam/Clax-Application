// Dart
import 'dart:typed_data';
// Models
import 'package:clax/models/Car.dart';
import 'package:clax/models/Name.dart';

class DriverModel {
  NameModel name;
  String phone;
  Uint8List profilePic;
  Car carInfo;

  DriverModel({this.name, this.phone, this.profilePic, this.carInfo});

  DriverModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? new NameModel.fromJson(json['name']) : null;
    phone = json['phone'];
    profilePic = Uint8List.fromList(json["profilePic"]);
    carInfo =
        json['carInfo'] != null ? new Car.fromJson(json['carInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.name != null) {
      data['name'] = this.name.toJson();
    }
    data['phone'] = this.phone;
    data['profilePic'] = this.profilePic;
    if (this.carInfo != null) {
      data['carInfo'] = this.carInfo.toJson();
    }
    return data;
  }
}

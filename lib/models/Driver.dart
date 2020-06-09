// Models
import 'package:clax/models/Car.dart';
import 'package:clax/models/Name.dart';

class DriverModel {
  NameModel name;
  String phone;
  String img;
  CarInfo carInfo;

  DriverModel({this.name, this.phone, this.img, this.carInfo});

  DriverModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? new NameModel.fromJson(json['name']) : null;
    phone = json['phone'];
    img = json['img'];
    carInfo =
        json['carInfo'] != null ? new CarInfo.fromJson(json['carInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.name != null) {
      data['name'] = this.name.toJson();
    }
    data['phone'] = this.phone;
    data['img'] = this.img;
    if (this.carInfo != null) {
      data['carInfo'] = this.carInfo.toJson();
    }
    return data;
  }
}

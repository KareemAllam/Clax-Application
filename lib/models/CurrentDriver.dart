// Dart
import 'dart:typed_data';
// Models
import 'package:clax/models/Car.dart';
import 'package:clax/models/Name.dart';

/// 1. *String* **driverId**
/// 2. *String* **phone**
/// 3. *String* **img**
/// 4. *NameModel* **name**
/// 5. *Car* **car**

class CurrentDriver {
  String driverId;
  String phone;
  Uint8List profilePic;
  NameModel name;
  Car car;

  CurrentDriver(
      {this.driverId, this.car, this.profilePic, this.name, this.phone});

  CurrentDriver.fromJson(Map<String, dynamic> json) {
    driverId = json['driverId'];
    phone = json['phone'];
    profilePic = Uint8List.fromList(List<int>.from(json['profilePic']));
    name = NameModel.fromJson(json['name']);
    car = Car.fromJson(json['car']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['driverId'] = this.driverId;
    data['phone'] = this.phone;
    data['profilePic'] = this.profilePic;
    data['name'] = this.name.toJson();
    data['car'] = this.car.toJson();
    return data;
  }
}

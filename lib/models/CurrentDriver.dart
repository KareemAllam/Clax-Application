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
  String img;
  NameModel name;
  Car car;

  CurrentDriver({this.driverId, this.car, this.img, this.name, this.phone});

  CurrentDriver.fromJson(Map<String, dynamic> json) {
    driverId = json['driverId'];
    phone = json['phone'];
    img = json['img'];
    name = NameModel.fromJson(json['name']);
    car = Car.fromJson(json['car']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['driverId'] = this.driverId;
    data['phone'] = this.phone;
    data['img'] = this.img;
    data['name'] = this.name.toJson();
    data['car'] = this.car.toJson();
    return data;
  }
}

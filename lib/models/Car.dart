import 'dart:math';

/// 1. *String* **id**
/// 2. *String* **color**
/// 3. *String* **plateNumber**
///
class Car {
  String id;
  String color;
  String plateNumber;

  Car({this.id, this.color, this.plateNumber});

  Car.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? "${Random().nextInt(100)}";
    color = json['color'];
    plateNumber = json['plateNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['color'] = this.color;
    data['plateNumber'] = this.plateNumber;
    return data;
  }
}

List<Car> staticCars = [
  Car(id: "${Random().nextInt(100)}", color: "حمراء", plateNumber: "9357"),
  Car(id: "${Random().nextInt(100)}", color: "زرقاء", plateNumber: "8732")
];

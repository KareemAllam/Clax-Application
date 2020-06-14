/// 1. *String* **color**
/// 2. *String* **plateNumber**
///
class Car {
  String color;
  String plateNumber;

  Car({this.color, this.plateNumber});

  Car.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    plateNumber = json['plateNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    data['plateNumber'] = this.plateNumber;
    return data;
  }
}

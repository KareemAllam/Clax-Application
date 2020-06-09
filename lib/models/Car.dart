class CarInfo {
  String number;
  String color;

  CarInfo({this.number, this.color});

  CarInfo.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['color'] = this.color;
    return data;
  }
}

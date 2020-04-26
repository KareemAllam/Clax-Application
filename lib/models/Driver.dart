class DriverModel {
  String img;
  String name;

  DriverModel({this.img, this.name});

  DriverModel.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    name = json['name'] ?? "404";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    data['name'] = this.name;
    return data;
  }
}

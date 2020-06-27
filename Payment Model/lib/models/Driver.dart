class Driver {
  String img;
  String name;

  Driver({this.img, this.name});

  Driver.fromJson(Map<String, dynamic> json) {
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

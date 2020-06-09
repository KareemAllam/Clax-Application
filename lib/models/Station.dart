class StationModel {
  List<double> coordinates;
  String id;
  String name;

  StationModel({this.coordinates, this.id, this.name});

  StationModel.fromJson(Map<String, dynamic> json) {
    coordinates = json['coordinates'].cast<double>();
    id = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coordinates'] = this.coordinates;
    data['_id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

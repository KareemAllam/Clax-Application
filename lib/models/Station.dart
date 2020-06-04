class Line {
  List<Station> stations;
  String id;
  String from;
  String to;
  double cost;

  Line({this.stations, this.id, this.from, this.to, this.cost});

  Line.fromJson(Map<String, dynamic> json) {
    if (json['_stations'] != null) {
      stations = List<Station>();
      json['_stations'].forEach((v) {
        stations.add(Station.fromJson(v));
      });
    }
    id = json['_id'];
    from = json['from'];
    to = json['to'];
    cost = double.parse(json['cost'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.stations != null) {
      data['_stations'] = this.stations.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.id;
    data['from'] = this.from;
    data['to'] = this.to;
    data['cost'] = this.cost;
    return data;
  }
}

class Station {
  List<double> coordinates;
  String id;
  String name;

  Station({this.coordinates, this.id, this.name});

  Station.fromJson(Map<String, dynamic> json) {
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

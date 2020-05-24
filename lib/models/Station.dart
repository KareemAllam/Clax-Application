class Station {
  List<StationLine> lines;
  String id;
  String from;
  String to;
  int cost;

  Station({this.lines, this.id, this.from, this.to, this.cost});

  Station.fromJson(Map<String, dynamic> json) {
    if (json['_stations'] != null) {
      lines = new List<StationLine>();
      json['_stations'].forEach((v) {
        lines.add(new StationLine.fromJson(v));
      });
    }
    id = json['_id'];
    from = json['from'];
    to = json['to'];
    cost = json['cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lines != null) {
      data['_stations'] = this.lines.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.id;
    data['from'] = this.from;
    data['to'] = this.to;
    data['cost'] = this.cost;
    return data;
  }
}

class StationLine {
  List<double> coordinates;
  String id;
  String name;

  StationLine({this.coordinates, this.id, this.name});

  StationLine.fromJson(Map<String, dynamic> json) {
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

// Models
import 'package:clax/models/Station.dart';

class LineModel {
  List<StationModel> stations;
  String id;
  String from;
  String to;
  double cost;

  LineModel({this.stations, this.id, this.from, this.to, this.cost});

  LineModel.fromJson(Map<String, dynamic> json) {
    if (json['_stations'] != null) {
      stations = List<StationModel>();
      json['_stations'].forEach((v) {
        stations.add(StationModel.fromJson(v));
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

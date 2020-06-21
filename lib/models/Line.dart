// Models
import 'dart:math';
import 'package:clax/models/Station.dart';

class LineModel {
  String id;
  StationModel start;
  StationModel end;
  double cost;
  LineModel(this.start, this.end, this.cost, {this.id = '2131'});

  LineModel.fromJson(Map<String, dynamic> json) {
    id = '${Random().nextInt(1000)}';
    start = StationModel(
        id: "tanta", coordinates: [30.8092, 30.99660], name: "طنطا");
    end = StationModel(
        id: "samanoud", coordinates: [30.96154, 31.240960], name: "سمنود");
    json['cost'] is String
        ? cost = double.parse(json['cost'])
        : json['cost'].toDobule();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["start"] = this.start.toJson();
    data["end"] = this.end.toJson();
    data['cost'] = this.cost;
    return data;
  }
}

List<LineModel> staticLines = [
  LineModel(
      StationModel(coordinates: [30.8092, 30.9966], id: "1", name: "طنطا"),
      StationModel(coordinates: [30.96154, 31.240690], id: "2", name: "سمنود"),
      3.5,
      id: "5e7164c94b168835e419a6d7"),
  LineModel(
      StationModel(coordinates: [30.96154, 31.240690], id: "2", name: "سمنود"),
      StationModel(
          coordinates: [31.0522251, 31.3731608], id: "3", name: "طلخا"),
      8,
      id: "5e716d485797b82358227805")
];

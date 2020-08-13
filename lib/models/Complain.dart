import 'dart:convert' as JSON;
import 'dart:typed_data';
import 'package:clax/models/Name.dart';

class ComplainModel {
  DateTime date;
  String response;
  String status;
  String subject;
  String text;
  int code;
  String lineName;
  NameModel driverName;
  Uint8List profilePic;

  ComplainModel(
      {this.subject,
      this.response,
      this.status,
      this.lineName,
      this.text,
      this.code,
      this.date,
      this.driverName,
      this.profilePic});

  ComplainModel.fromJson(Map<String, dynamic> json) {
    response = json['response'] ?? '';
    status = json['status'] ?? '';
    subject = json['subject'];
    text = json['text'] ?? '';
    code = json['code'] ?? 404;
    date = DateTime.parse(json['date']) ?? DateTime.now();
    if (json["_trip"] != null) {
      lineName = json['_trip']['_line'];
      driverName = NameModel.fromJson(json['_trip']["_driver"]['name']);
      profilePic =
          JSON.base64Decode(json['_trip']["_driver"]["profilePic"]['data']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response ?? null;
    data['status'] = this.status;
    data['subject'] = this.subject;
    data['text'] = this.text;
    data['code'] = this.code;
    data['date'] = this.date.toString();
    if (this.lineName != null) {
      data['_trip'] = Map();
      data['_trip']['_line'] = this.lineName;
      data['_trip']["_driver"] = {"name": Map(), "profilePic": Map()};
      data['_trip']["_driver"]['name'] = this.driverName?.toJson();
      data['_trip']['_driver']['profilePic']['data'] =
          JSON.base64Encode(this.profilePic.toList()) ?? null;
    }
    return data;
  }
}

// Models
import 'package:clax/models/Name.dart';

class ProfileModel {
  NameModel name;
  String phone;
  String passHashed;
  int passLength;
  bool phoneVerified;

  ProfileModel(
      {this.name,
      this.phone,
      this.passHashed,
      this.passLength,
      this.phoneVerified});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? new NameModel.fromJson(json['name']) : null;
    phone = json['phone'];
    passHashed = json['pass'];
    passLength = json['passLength'];
    phoneVerified = json['phone_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.name != null) {
      data['name'] = this.name.toJson();
    }
    data['phone'] = this.phone;
    data['pass'] = this.passHashed;
    data['passLength'] = this.passLength;
    data['phone_verified'] = this.phoneVerified;
    return data;
  }
}

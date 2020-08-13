// Models
import 'package:clax/models/Name.dart';

class ProfileModel {
  NameModel name;
  String mail;
  String phone;
  String passHashed;
  int passLength;
  bool mailVerified;
  bool phoneVerified;
  ProfileModel(
      {this.name,
      this.mail,
      this.phone,
      this.passHashed,
      this.passLength,
      this.mailVerified,
      this.phoneVerified});
  ProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? new NameModel.fromJson(json['name']) : null;
    mail = json['mail'];
    phone = json['phone'];
    passHashed = json['pass'];
    passLength = json['passLength'] is String
        ? int.parse(json['passLength'])
        : json['passLength'];
    mailVerified = json['mail_verified'];
    phoneVerified = json['phone_verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.name != null) {
      data['name'] = this.name.toJson();
    }
    data['mail'] = this.mail;
    data['phone'] = this.phone;
    data['pass'] = this.passHashed;
    data['passLength'] = this.passLength;
    data['mail_verified'] = this.mailVerified;
    data['phone_verified'] = this.phoneVerified;
    return data;
  }
}

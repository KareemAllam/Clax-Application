// Models
import 'package:clax/models/Name.dart';

class FamilyMember {
  String id;
  NameModel name;
  String phone;

  FamilyMember({this.id, this.name, this.phone});

  FamilyMember.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? "";
    name = NameModel.fromJson(json['name']);
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}

class FamilymemberModel {
  String sId;
  String name;
  String phone;

  FamilymemberModel({this.sId, this.name, this.phone});

  FamilymemberModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    return data;
  }
}

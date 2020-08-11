class NameModel {
  String first;
  String last;

  NameModel({this.first, this.last});

  NameModel.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    return data;
  }

  String toString() {
    return first + " " + last;
  }
}

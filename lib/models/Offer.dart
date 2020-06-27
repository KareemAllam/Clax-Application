class Offer {
  String id;
  String title;
  String code;
  String offerType;
  String description;
  double value;
  DateTime end;

  Offer(
      {this.id,
      this.title,
      this.code,
      this.end,
      this.value,
      this.offerType,
      this.description});

  Offer.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    offerType = json['offerType'];
    code = json['code'];
    end = DateTime.parse(json['end']);
    value = json['value'].toDouble();
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['title'] = this.title;
    data['code'] = this.code;
    data['end'] = this.end.toString();
    data['offerType'] = this.offerType;
    data['description'] = this.description;
    data['value'] = this.value;
    return data;
  }
}

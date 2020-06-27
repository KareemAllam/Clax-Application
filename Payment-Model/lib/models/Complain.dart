class Complain {
  DateTime date;
  String response;
  String status;
  String tripId;
  String text;
  int code;

  Complain(
      {this.response,
      this.status,
      this.tripId,
      this.text,
      this.code,
      this.date});

  Complain.fromJson(Map<String, dynamic> json) {
    response = json['response'] ?? '';
    status = json['status'] ?? '';
    tripId = json['_trip'] ?? '';
    text = json['text'] ?? '';
    code = json['code'] ?? 404;
    date = DateTime.parse(json['date']) ?? DateTime.now();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['status'] = this.status;
    data['_trip'] = this.tripId;
    data['text'] = this.text;
    data['code'] = this.code;
    data['date'] = this.date.toString();
    return data;
  }
}

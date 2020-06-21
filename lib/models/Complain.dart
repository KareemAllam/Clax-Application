class ComplainModel {
  DateTime date;
  String response;
  String status;
  String tripId;
  String subject;
  String text;
  int code;

  ComplainModel(
      {this.subject,
      this.response,
      this.status,
      this.tripId,
      this.text,
      this.code,
      this.date});

  ComplainModel.fromJson(Map<String, dynamic> json) {
    response = json['response'] ?? '';
    status = json['status'] ?? '';
    subject = json['subject'];
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
    data['subject'] = this.subject;
    data['text'] = this.text;
    data['code'] = this.code;
    data['date'] = this.date.toString();
    return data;
  }
}

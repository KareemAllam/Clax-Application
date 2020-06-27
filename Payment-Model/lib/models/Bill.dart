class Bill {
  int amount;
  String description;
  String type;
  DateTime date;

  Bill({this.amount, this.description, this.type, this.date});

  Bill.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    description = json['description'];
    type = json['type'];
    date = DateTime.parse(json['date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['type'] = this.type;
    data['date'] = this.date;
    return data;
  }
}

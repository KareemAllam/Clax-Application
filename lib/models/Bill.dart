class BillModel {
  int amount;
  String description;
  String type;
  DateTime date;

  BillModel({this.amount, this.description, this.type, this.date});

  BillModel.fromJson(Map<String, dynamic> json) {
    amount = int.parse(json['amount']);
    description = json['description'];
    type = json['type'];
    date = DateTime.parse(json['date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount.toString();
    data['description'] = this.description;
    data['type'] = this.type;
    data['date'] = this.date.toString();
    return data;
  }
}

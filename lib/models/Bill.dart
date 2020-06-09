/// Type: Punishment - Pay - Charge - Lend
class BillModel {
  double amount;
  String description;
  String type;
  DateTime date;

  BillModel({this.amount, this.description, this.type, this.date});

  BillModel.fromJson(Map<String, dynamic> json) {
    amount = double.parse(json['amount'].toString());
    description = json['description'];
    type = json['type'];
    date = DateTime.now();
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

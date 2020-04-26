class TransactionModel {
  String id;
  int amount;
  String loaneeNamed;
  String date;

  TransactionModel({this.id, this.amount, this.loaneeNamed, this.date});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    amount = json['amount'];
    loaneeNamed = json['loaneeNamed'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['amount'] = this.amount;
    data['loaneeNamed'] = this.loaneeNamed;
    data['date'] = this.date;
    return data;
  }
}

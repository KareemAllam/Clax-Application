class Transaction {
  String id;
  int amount;
  String loaneeNamed;
  String date;

  Transaction({this.id, this.amount, this.loaneeNamed, this.date});

  Transaction.fromJson(Map<String, dynamic> json) {
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

class CreditCardModel {
  String id;
  int expYear;
  int expMonth;
  String last4;
  String brand;

  CreditCardModel(
      {this.id, this.expYear, this.expMonth, this.last4, this.brand});

  CreditCardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expYear = json['exp_year'];
    expMonth = json['exp_month'];
    last4 = json['last4'];
    brand = json['brand'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['exp_year'] = this.expYear;
    data['exp_month'] = this.expMonth;
    data['last4'] = this.last4;
    data['brand'] = this.brand;
    return data;
  }
}

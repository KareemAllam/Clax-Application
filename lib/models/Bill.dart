/// Type: Punishment - Pay - Charge - Lend
class BillModel {
  String name;
  int totalSeats;
  double ppc;
  DateTime date;

  BillModel({this.name, this.totalSeats, this.ppc, this.date});

  BillModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    totalSeats = int.parse(json['totalCost'].toString());
    ppc = double.parse(json['ppc'].toString());
    date = DateTime.now();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['totalCost'] = this.totalSeats;
    data['ppc'] = this.ppc;
    data['date'] = this.date.toString();
    return data;
  }
}

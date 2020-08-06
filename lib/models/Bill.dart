/// Type: Punishment - Pay - Charge - Lend
class BillModel {
  DateTime date;
  String lineName;
  double cost;
  int seats;

  BillModel({this.date, this.lineName, this.cost, this.seats});

  BillModel.fromJson(Map<String, dynamic> json) {
    date = DateTime.parse(json['date']);
    (json['line'] is Map)
        ? lineName = new Line.fromJson(json['line']).toString()
        : lineName = json['line'] != null ? json['line'] : "غير معروف";

    cost = json['cost'].toDouble();
    seats = json['seats'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date.toString();
    if (this.lineName != null) {
      data['line'] = this.lineName;
    }
    data['cost'] = this.cost;
    data['seats'] = this.seats;
    return data;
  }
}

class Line {
  String from;
  String to;

  Line({this.from, this.to});

  Line.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }

  String toString() {
    return from + " " + to;
  }
}

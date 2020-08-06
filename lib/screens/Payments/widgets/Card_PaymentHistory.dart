import 'package:flutter/material.dart';
import 'package:clax/models/Bill.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart' as intl;

List days = [
  'السبت',
  "الحد",
  "الاتنين",
  "الثلثاء",
  "الاربعاء",
  "الخميس",
  "الجمعة"
];

class BillCard extends StatelessWidget {
  final BillModel bill;
  BillCard({this.bill});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey[300]))),
      padding: EdgeInsets.all(16),
      child: Row(children: [
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerRight,
            child: Icon(FontAwesomeIcons.route,
                color: Theme.of(context).primaryColor),
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          flex: 3,
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              bill.lineName,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              '${bill.seats} كراسي',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.grey),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              intl.DateFormat.E('ar_AE').format(bill.date),
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.grey),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              '${bill.cost}',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Product Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ]),
    );
  }
}

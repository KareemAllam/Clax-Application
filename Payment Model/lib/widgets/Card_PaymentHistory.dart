import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/Bill.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:math';

class BillCard extends StatelessWidget {
  final Bill bill;
  final String brand;
  BillCard({this.bill, this.brand});
  @override
  Widget build(BuildContext context) {
    Widget icon;
    String title = '';
    String msg = '';
    if (bill.type == "Punishment") {
      icon = Icon(Icons.departure_board, color: Theme.of(context).primaryColor);
      title = 'عقوبة';
      msg = bill.description;
    } else if (bill.type == "Pay") {
      icon = Icon(Icons.bookmark_border, color: Theme.of(context).primaryColor);
      title = bill.description;
      msg = 'اجرة السائق';
    } else if (bill.type == "Charge") {
      icon = Icon(Icons.payment, color: Theme.of(context).primaryColor);
      title = bill.description;
      msg = 'تم إضافة';
    } else if (bill.type == "Lend") {
      icon = Icon(Icons.keyboard_tab, color: Theme.of(context).primaryColor);
      title = bill.description;
      msg = "تم تحويل";
    } else {
      // bill type: Borrow
      title = bill.description;
      msg = 'تم استلاف';
      icon = Transform.rotate(
        angle: 180 * pi / 180,
        child: Icon(Icons.keyboard_tab, color: Theme.of(context).primaryColor),
      );
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          ExpansionTile(
            title: Container(
              // padding: EdgeInsets./symmetric(horizontal: 20),
              child: Row(children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: icon,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  flex: 6,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      brand == ('Visa')
                          ? "فيزا"
                          : brand == "Mastercard" ? 'ماستر كارد' : title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      bill.type == "Borrow" || bill.type == "Charge"
                          ? "+" + bill.amount.toString()
                          : "-" + bill.amount.toString(),
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
            ),
            children: <Widget>[
              Container(
                height: 50,
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        bill.type == "Punishment"
                            ? msg
                            : msg + " " + bill.amount.toString() + " " + 'جنية',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    // VerticalDivider(
                    //   width: 1,
                    // ),
                    Expanded(
                      child: Text(
                          intl.DateFormat('MMMM d  h:mm a')
                              .format(bill.date)
                              .toString(),
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              color: Colors.white60,
                              fontFamily: 'Product Sans')),
                    ),
                  ],
                ),
              )
            ],
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}

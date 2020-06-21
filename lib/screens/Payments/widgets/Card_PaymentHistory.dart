import 'package:flutter/material.dart';
import 'package:clax/models/Bill.dart';
import 'package:intl/intl.dart' as intl;

class BillCard extends StatelessWidget {
  final BillModel bill;
  BillCard({this.bill});
  @override
  Widget build(BuildContext context) {
    Widget icon;

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
                  flex: 7,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      bill.name,
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
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "+" + '${bill.ppc * bill.totalSeats}',
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
                        "Punishment",
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

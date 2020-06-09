// Dart & Other Pacakges
import 'dart:convert';
import 'package:provider/provider.dart';
// Flutter Material Components
import 'package:flutter/material.dart';
// Models
import 'package:clax/models/Bill.dart';
import 'package:clax/models/Transaction.dart';
// Providers
import 'package:clax/providers/Payment.dart';
import 'package:clax/providers/Transactions.dart';
// Widgets
import 'package:clax/screens/Payments/widgets/Confirmation.dart';

class MemberInvitationCard extends StatelessWidget {
  final TransactionModel transaction;
  MemberInvitationCard({Key key, this.transaction});

  @override
  Widget build(BuildContext context) {
    var transactions = Provider.of<TransactionsProvider>(context);
    var account = Provider.of<PaymentProvider>(context, listen: false);
    var payments = Provider.of<PaymentProvider>(context, listen: false);
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.black12, width: 0),
              bottom: BorderSide(color: Colors.black12, width: 0),
            )),
        child: Row(
          children: <Widget>[
            Icon(Icons.arrow_forward, color: Colors.black87),
            SizedBox(width: 20),
            // Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  transaction.loaneeNamed,
                  strutStyle: StrutStyle(forceStrutHeight: true),
                  style: Theme.of(context).textTheme.bodyText2.copyWith(),
                ),
              ],
            ),
            SizedBox(width: 10),

            Text(
              "- " + transaction.amount.toString() + " جنيه مصري",
              strutStyle: StrutStyle(forceStrutHeight: true),
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(fontSize: 14, color: Colors.black26),
            ),
            Spacer(),
            Container(
              width: 30,
              child: IconButton(
                  padding: EdgeInsets.all(0),
                  alignment: Alignment.centerRight,
                  tooltip: "قبول الدعوة",
                  icon: Icon(
                    Icons.add_circle,
                    color: Colors.green,
                  ),
                  onPressed: () async {
                    await showAlertDialog(context,
                        text: RichText(
                          text: TextSpan(
                            text: 'سيتم ارسال مبلغ ',
                            style: DefaultTextStyle.of(context)
                                .style
                                .copyWith(color: Colors.grey),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '${transaction.amount} جنيه',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87)),
                              TextSpan(text: ' إلى '),
                              TextSpan(
                                  text: '${transaction.loaneeNamed}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  )),
                            ],
                          ),
                        ), cb: () async {
                      String result =
                          await transactions.acceptARequest(transaction.id);
                      if (result != 'Error') {
                        account.setBalance = -transaction.amount.toDouble();
                        BillModel bill =
                            BillModel.fromJson(json.decode(result));
                        payments.add(bill);
                      }
                    });
                  }),
            ),
            Container(
              width: 30,
              child: IconButton(
                  // padding: EdgeInsets.all(0),
                  alignment: Alignment.centerLeft,
                  tooltip: "رفض الدعوة",
                  icon: Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    await transactions.cancelARequest(transaction.id, 'Loaner');
                  }),
            )
          ],
        ));
  }
}

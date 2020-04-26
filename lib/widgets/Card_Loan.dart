import 'package:clax/providers/Account.dart';
import 'package:clax/providers/Payments.dart';
import 'package:clax/widgets/Confirmation.dart';

import 'package:provider/provider.dart';
import '../models/Transaction.dart';
import '../providers/Transactions.dart';
import 'package:flutter/material.dart';

class MemberInvitationCard extends StatelessWidget {
  final TransactionModel transaction;
  MemberInvitationCard({Key key, this.transaction});

  @override
  Widget build(BuildContext context) {
    var transactions = Provider.of<TransactionsProvider>(context);
    var account = Provider.of<AccountProvider>(context, listen: false);
    var payments = Provider.of<PaymentsProvider>(context, listen: false);
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
                          text: new TextSpan(
                            text: 'هل انت متأكد من انك تريد ارسال مبلغ ',
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              new TextSpan(
                                  text: '${transaction.amount}',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold)),
                              new TextSpan(text: ' جنيه مصري إلى '),
                              new TextSpan(
                                  text: '${transaction.loaneeNamed}',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold)),
                              new TextSpan(text: ' ؟ '),
                            ],
                          ),
                        ), cb: () async {
                      String result = await transactions.accept(transaction.id);
                      if (result != 'false') {
                        account.balance = -transaction.amount.toDouble();
                        payments.add(result);
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
                    await transactions.cancel(transaction.id, 'Loaner');
                  }),
            )
          ],
        ));
  }
}

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
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.black12, width: 0),
              bottom: BorderSide(color: Colors.black12, width: 0),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.arrow_forward, color: Colors.black87),
                SizedBox(width: 16),
                Text(
                  transaction.loaneeNamed,
                  strutStyle: StrutStyle(forceStrutHeight: true),
                  style: Theme.of(context).textTheme.bodyText2.copyWith(),
                ),
                Text(
                  "  - " + transaction.amount.toString() + " جنيه مصري",
                  strutStyle: StrutStyle(forceStrutHeight: true),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(fontSize: 14, color: Colors.black26),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 28,
                  child: RawMaterialButton(
                      padding: EdgeInsets.all(0),
                      fillColor: Colors.green,
                      shape: CircleBorder(),
                      elevation: 0,
                      highlightElevation: 0,
                      child: Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 20,
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
                                          // fontWeight: FontWeight.bold,
                                          color: Colors.black87)),
                                  TextSpan(text: ' إلى '),
                                  TextSpan(
                                      text: '${transaction.loaneeNamed}',
                                      style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      )),
                                ],
                              ),
                            ), cb: () async {
                          String result =
                              await transactions.acceptARequest(transaction.id);
                          if (result != 'Error') {
                            account
                                .updateBalance(-transaction.amount.toDouble());
                            BillModel bill =
                                BillModel.fromJson(json.decode(result));
                            payments.add(bill);
                          }
                        });
                      }),
                ),
                SizedBox(width: 18),
                Container(
                  width: 28,
                  child: RawMaterialButton(
                    onPressed: () async {
                      await transactions.cancelARequest(
                          transaction.id, 'Loaner');
                    },
                    fillColor: Colors.red,
                    padding: EdgeInsets.all(0),
                    elevation: 0,
                    highlightElevation: 0,

                    // alignment: Alignment.centerLeft,
                    // tooltip: "رفض الدعوة",
                    shape: CircleBorder(),
                    child: Icon(
                      Icons.delete,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }
}

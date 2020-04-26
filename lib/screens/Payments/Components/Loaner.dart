// Dart & Other Packages
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Providers
import 'package:clax/providers/Transactions.dart';
// Models
import 'package:clax/models/Transaction.dart';
// Widgets
import 'package:clax/widgets/null.dart';
import 'package:clax/widgets/Card_Loan.dart';

class Loaner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    List<TransactionModel> transactions =
        Provider.of<TransactionsProvider>(context).tranactions ?? [];
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  "دعوات الاستلاف",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.w700, fontSize: 20),
                )),
            SizedBox(height: 10),
            if (transactions.length != 0)
              ...transactions.map((e) => MemberInvitationCard(transaction: e))
            else
              Container(
                  alignment: Alignment.center,
                  height: height - height * 0.4,
                  child: NullContent(things: "دعوات")),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

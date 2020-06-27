import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Provider/Account.dart';
import 'package:flutter_complete_guide/Provider/Payments.dart';
import 'package:flutter_complete_guide/models/Bill.dart';
import 'package:flutter_complete_guide/models/CreditCard.dart';
import 'package:flutter_complete_guide/widgets/null.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../widgets/Card_PaymentHistory.dart';
// import 'dart:convert';

class PaymentHistory extends StatefulWidget {
  @override
  _PaymentHistoryState createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  bool loading = false;
  ScrollController _controller = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Widget build(BuildContext context) {
    List<CreditCard> cards = Provider.of<Account>(context, listen: false).cards;
    var billsProvider = Provider.of<Payments>(context, listen: false);
    List<Bill> bills = billsProvider.bills;
    bills.sort((a, b) => b.date.compareTo(a.date));

    double height = MediaQuery.of(context).size.height;

    updateData() async {
      setState(() {
        loading = true;
      });
      await billsProvider.fetchData();
      setState(() {
        loading = false;
      });
    }

    String getBrand(index) {
      try {
        return cards.firstWhere((element) {
          return element.id == bills[index].description;
        }).brand;
      } catch (_) {
        return "ميزة";
      }
    }

    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            loading
                ? Container(
                    margin: EdgeInsets.only(left: 10),
                    child: SpinKitChasingDots(size: 20, color: Colors.white))
                : IconButton(
                    icon: Icon(Icons.refresh, color: Colors.white),
                    onPressed: updateData)
          ],
          elevation: 0.0,
          title: Text('سجل مدفوعاتك',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white)),
        ),
        body: bills.length == 0
            ? Container(
                height: height * 0.8,
                alignment: Alignment.center,
                child: NullContent(
                  things: "مدفوعات",
                ))
            : ListView.builder(
                physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                controller: _controller,
                itemBuilder: (ctx, index) {
                  return BillCard(
                    brand: getBrand(index),
                    bill: bills[index],
                  );
                },
                itemCount: bills.length,
              ));
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/Account.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('تجارب',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.white))),
        body: ChangeNotifierProvider(
          create: (context) => Account(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("رفيع",
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 22,
                      fontWeight: FontWeight.values[0])),
              Text("ناعم",
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 22,
                      fontWeight: FontWeight.values[2])),
              Text("متوسط",
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 22,
                      fontWeight: FontWeight.values[4])),
              Text("ثقيل",
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 22,
                      fontWeight: FontWeight.values[6])),
              Text("اسود",
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 22,
                      fontWeight: FontWeight.values[8])),
              Consumer<Account>(
                builder: (context, account, child) =>
                    Text(account.balance.toString()),
              ),
              Consumer<Account>(
                  builder: (context, account, child) => TextField(
                        onSubmitted: (value) {
                          account.updateBalanceUsingCard(double.parse(value));
                        },
                      ))
            ],
          ),
        ));
  }
}

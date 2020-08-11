// Flutter's Material Components
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// Providers
import 'package:clax/providers/Payment.dart';
// Models
import 'package:clax/models/Bill.dart';
// Widgets
import 'package:clax/screens/Payments/widgets/Card_PaymentHistory.dart';
import 'package:clax/widgets/null.dart';

class PaymentHistory extends StatefulWidget {
  static const routeName = '/payment/payment_history';
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
    List<BillModel> bills = Provider.of<PaymentProvider>(context).bills;
    bills.sort((a, b) => b.date.compareTo(a.date));

    double height = MediaQuery.of(context).size.height;

    updateData() async {
      setState(() {
        loading = true;
      });
      await Provider.of<PaymentProvider>(context, listen: false).serverData();
      setState(() {
        loading = false;
      });
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
                reverse: true,
                physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                controller: _controller,
                itemBuilder: (ctx, index) {
                  return BillCard(
                    bill: bills[index],
                  );
                },
                itemCount: bills.length,
              ));
  }
}

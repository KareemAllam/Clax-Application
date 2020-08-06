// Dart & Other Packages
import 'package:clax/widgets/null.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Models
import 'package:clax/models/Bill.dart';
import 'package:clax/models/Error.dart';
// Providers
import 'package:clax/providers/Payment.dart';
// Widgets
import 'package:clax/widgets/ExtendedAppBar.dart';
import 'package:clax/screens/Payments/widgets/Card_PaymentHistory.dart';
// Components
import 'package:clax/screens/Payments/Components/PaymentExtendedAppBar.dart';
// Drawer
import 'package:clax/screens/Drawer.dart';

class PaymentScreen extends StatefulWidget {
  static const routeName = '/payments';
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  double balance = 0;
  bool refreshing = false;
  bool nic = false;

  Future updateData() async {
    setState(() {
      refreshing = true;
    });
    ServerResponse result =
        await Provider.of<PaymentProvider>(context, listen: false).serverData();
    if (result.status)
      setState(() {
        refreshing = false;
        nic = false;
      });
    else
      setState(() {
        refreshing = false;
        nic = true;
      });
  }

  Widget build(BuildContext context) {
    List<BillModel> bills = Provider.of<PaymentProvider>(context).bills;
    bills.sort((a, b) => b.date.compareTo(a.date));
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          actions: <Widget>[
            refreshing
                ? Container(
                    margin: EdgeInsets.only(left: 10),
                    child: SpinKitChasingDots(size: 20, color: Colors.white))
                : Builder(
                    builder: (context) => IconButton(
                        icon: Icon(Icons.refresh, color: Colors.white),
                        onPressed: updateData),
                  )
          ],
          elevation: 0.0,
          title: Text(
            'المدفوعات',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(height * 0.2),
            child: ExtendedAppbar(child: PaymentAppBarBottom()),
          ),
        ),
        body: bills.length == 0
            ? Container(
                height: height * 0.8,
                alignment: Alignment.center,
                child: NullContent(
                  things: "مدفوعات",
                ))
            : RefreshIndicator(
                displacement: 10,
                child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  controller: ScrollController(),
                  itemBuilder: (ctx, index) {
                    return BillCard(
                      bill: bills[index],
                    );
                  },
                  itemCount: bills.length,
                ),
                onRefresh: updateData));
  }
}

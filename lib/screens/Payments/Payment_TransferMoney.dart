// Dart & Other Packages
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Providers
import 'package:clax/providers/Transactions.dart';
// Widgets
import 'package:clax/screens/Payments/Components/Loanee.dart';
import 'package:clax/screens/Payments/Components/Loaner.dart';

class TransferMoney extends StatefulWidget {
  static const routeName = "/payment/transfer_money";
  @override
  _TransferMoneyState createState() => _TransferMoneyState();
}

class _TransferMoneyState extends State<TransferMoney>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    // accounts = getAccounts();
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تحويل فلوس',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white)),
        elevation: 0.0,
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
                icon: loading
                    ? SpinKitCircle(color: Colors.white, size: 30)
                    : Icon(Icons.refresh),
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  bool result = await Provider.of<TransactionsProvider>(context,
                          listen: false)
                      .getRequests();
                  setState(() {
                    loading = false;
                  });
                  if (!result)
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "تعذر الوصول للإنترنت. تأكد من اتصالك بالإنترنت و حاول مره اخرى.",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(color: Colors.white))));
                }),
          )
        ],
        bottom: TabBar(
          tabs: <Tab>[
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.file_download),
                  SizedBox(width: 10),
                  Text("استلف فلوس")
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.file_upload,
                  ),
                  SizedBox(width: 10),
                  Text("حول فلوس")
                ],
              ),
            ),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          Loanee(),
          Loaner(),
        ],
        controller: _tabController,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Provider/Transactions.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../Components/Loanee.dart';
import '../Components/Loaner.dart';
// import '../Components/deLoan.dart';

class TransferMoney extends StatefulWidget {
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
    final transactions = Provider.of<Transactions>(context);
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
                  bool result = await transactions.fetchData();
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

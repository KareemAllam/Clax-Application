import 'dart:async';
import 'package:clax/models/Bill.dart';
import 'package:clax/models/Error.dart';
import 'package:clax/providers/Payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaypalWeb extends StatefulWidget {
  static const routeName = '/payment/paypal';

  @override
  _PaypalWebState createState() => _PaypalWebState();
}

class _PaypalWebState extends State<PaypalWeb> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  Map<String, dynamic> args = Map();

  void validatePayment() async {
    ServerResponse result =
        await Provider.of<PaymentProvider>(context, listen: false)
            .finishPaypal(args['amount']);
    if (result.status) {
      BillModel bill = BillModel(
          date: DateTime.now(),
          amount: args['amount'],
          description: "باي بال",
          type: "Charge");
      Provider.of<PaymentProvider>(context, listen: false).add(bill);
      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          titlePadding: EdgeInsets.all(0),
          contentPadding: EdgeInsets.all(0),
          title: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5))),
            padding: EdgeInsets.only(top: 20, right: 15, left: 15, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "لم تتم العملية بنجاح.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.values[5]),
                ),
                SizedBox(height: 2),
                Text("تأكد من بياناتك و حاول مره اخرى في وقت لاحق",
                    style: Theme.of(context).textTheme.caption)
              ],
            ),
          ),
          content: Container(
              color: Theme.of(context).primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    child: Text("حسنا",
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold)),
                    onPressed: () async {
                      // Dismiss the Alert Dialoge Box
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                ],
              )),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = Map<String, dynamic>.from(ModalRoute.of(context).settings.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Paypal",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white, fontFamily: "Product Sans"),
          ),
        ),
        body: WebView(
          initialUrl: args['url'],
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains('success')) {
              validatePayment();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ));
  }
}

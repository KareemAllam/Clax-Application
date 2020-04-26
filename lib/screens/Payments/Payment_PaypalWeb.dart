import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaypalWeb extends StatelessWidget {
  static const routeName = '/payment/paypal';
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    var args =
        Map<String, String>.from(ModalRoute.of(context).settings.arguments);

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
            if (request.url.endsWith('/success')) {
              Navigator.pop(context);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ));
  }
}

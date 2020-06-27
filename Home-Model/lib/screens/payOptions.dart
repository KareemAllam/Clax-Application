import 'package:clax/widgets/appBar.dart';
import 'package:flutter/material.dart';

class PayOptions extends StatelessWidget {
  static const routeName = '/payOptions';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'طرق الدفع'),
      body: Text('data'),
    );
  }
}

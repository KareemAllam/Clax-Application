import 'package:clax/widgets/appBar.dart';
import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  static const routeName = '/creditCard';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'البطاقة الائتمانية'),
      body: Text('data'),
    );
  }
}

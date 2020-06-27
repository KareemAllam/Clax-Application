import 'package:clax/widgets/appBar.dart';
import 'package:flutter/material.dart';

class Wallet extends StatelessWidget {
  static const routeName = '/wallet';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'محفظة كلاكس'),
      body: Text('data'),
    );
  }
}

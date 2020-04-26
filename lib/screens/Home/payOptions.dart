// Flutter's Material Components
import 'package:flutter/material.dart';
// Widgets
import 'package:clax/widgets/appBar.dart';

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

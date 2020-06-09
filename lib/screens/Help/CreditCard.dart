// Flutter's Material Components
import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  static const routeName = '/creditCard';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('البطاقة الائتمانية',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white)),
      ),
      body: Text('data'),
    );
  }
}

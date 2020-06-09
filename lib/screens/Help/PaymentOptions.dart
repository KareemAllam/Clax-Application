// Flutter's Material Components
import 'package:flutter/material.dart';

class PayOptions extends StatelessWidget {
  static const routeName = '/payOptions';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('طرق الدفع',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white)),
      ),
      body: Text('data'),
    );
  }
}

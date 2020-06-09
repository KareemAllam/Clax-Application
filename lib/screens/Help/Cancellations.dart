// Flutter's Material Components
import 'package:flutter/material.dart';

class Cancellations extends StatelessWidget {
  static const routeName = '/cancellations';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('الالغاء',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white)),
      ),
      body: Text('data'),
    );
  }
}

// Flutter's Material Components
import 'package:flutter/material.dart';

class PromoCodes extends StatelessWidget {
  static const routeName = '/promoCodes';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('البروموكود',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white)),
      ),
      body: Text('data'),
    );
  }
}

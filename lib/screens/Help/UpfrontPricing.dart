// Flutter's Material Components
import 'package:flutter/material.dart';

class UpFrontPricing extends StatelessWidget {
  static const routeName = '/upFrontPricing';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('التعرفة الأولية',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white)),
      ),
      body: Text('data'),
    );
  }
}

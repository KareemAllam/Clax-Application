// Flutter's Material Components
import 'package:flutter/material.dart';
// Widgets
import 'package:clax/widgets/appBar.dart';

class UpFrontPricing extends StatelessWidget {
  static const routeName = '/upFrontPricing';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'التعرفة الأولية'),
      body: Text('data'),
    );
  }
}

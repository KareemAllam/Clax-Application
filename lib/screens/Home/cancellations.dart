// Flutter's Material Components
import 'package:flutter/material.dart';
// Widgets
import 'package:clax/widgets/appBar.dart';

class Cancellations extends StatelessWidget {
  static const routeName = '/cancellations';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'الإلغاء'),
      body: Text('data'),
    );
  }
}

// Flutter's Material Components
import 'package:flutter/material.dart';
// Widgets
import 'package:clax/widgets/appBar.dart';

class PromoCodes extends StatelessWidget {
  static const routeName = '/promoCodes';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'البروموكود'),
      body: Text('data'),
    );
  }
}

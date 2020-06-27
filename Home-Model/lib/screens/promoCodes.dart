import 'package:clax/widgets/appBar.dart';
import 'package:flutter/material.dart';

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

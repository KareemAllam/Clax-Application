import 'package:clax/widgets/appBar.dart';

import '../widgets/drawer.dart';
import 'package:flutter/material.dart';

class Signout extends StatelessWidget {
  static const routeName = '/Signout';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'تسجيل الخروج'),
      drawer: MainDrawer(),
      body: Center(
        child: Text('...'),
      ),
    );
  }
}

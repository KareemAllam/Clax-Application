// Flutter's Material Components
import 'package:flutter/material.dart';
// Widgets
import 'package:clax/widgets/appBar.dart';
import 'package:clax/widgets/drawer.dart';

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

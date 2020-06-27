import 'package:clax/widgets/appBar.dart';
import 'package:clax/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Pay extends StatefulWidget {
  static const routeName = '/pay';

  @override
  _PayState createState() => _PayState();
}

class _PayState extends State<Pay> {
  List<dynamic> data;
  bool fetched = false;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, 'الدفع'),
        drawer: MainDrawer(),
        body: Container(
          child: fetched
              ? Text("!Successfully Fetched")
              : SpinKitCircle(
                  size: MediaQuery.of(context).size.height * 0.13,
                  color: Theme.of(context).primaryColor,
                  duration: Duration(milliseconds: 500),
                ),
        ));
  }
}

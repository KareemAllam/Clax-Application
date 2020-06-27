import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NewTrip extends StatefulWidget {
  @override
  _NewTripState createState() => _NewTripState();
}

class _NewTripState extends State<NewTrip> {
  List<dynamic> data;
  bool fetched = false;
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: fetched
          ? Text("!Successfully Fetched")
          : SpinKitCircle(
              size: MediaQuery.of(context).size.height * 0.13,
              color: Theme.of(context).primaryColor,
              duration: Duration(milliseconds: 500),
            ),
    );
  }
}

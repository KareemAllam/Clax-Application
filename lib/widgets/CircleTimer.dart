import 'dart:async';
import 'package:flutter/material.dart';

class CircleTimer extends StatefulWidget {
  @override
  _CircleTimerState createState() => _CircleTimerState();
}

class _CircleTimerState extends State<CircleTimer> {
  double _progress = 0.0;
  String seconds;
  Timer time;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    time = Timer.periodic(
      Duration(microseconds: 10000),
      (Timer timer) => setState(
        () {
          if (_progress == 1) {
            timer.cancel();
          } else {
            _progress += 0.001;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    time.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: Colors.grey,
      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
      strokeWidth: 3,
      value: _progress,
    );
  }
}

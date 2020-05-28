// import 'package:clax/screens/Home/Components/RideDriverInfo.dart';
import 'package:clax/screens/MakeARide/Components/RideInfo.dart';
import 'package:clax/screens/MakeARide/Components/RideSearching.dart';
import 'package:flutter/material.dart';

class StartARide extends StatefulWidget {
  static const routeName = '/startARide';

  @override
  _StartARideState createState() => _StartARideState();
}

class _StartARideState extends State<StartARide> with TickerProviderStateMixin {
  // Animation Key
  Map<String, dynamic> _currentWidget;
  int widgetIndex = 0;
  List<Map<String, dynamic>> states;
  // Functionlity
  void changeWidget() {
    setState(() {
      _currentWidget = states[++widgetIndex % states.length];
    });
  }

  @override
  void initState() {
    super.initState();
    states = [
      {"title": RideInfo.titleName, 'widget': RideInfo(changeWidget)},
      {"title": RideSearching.titleName, 'widget': RideSearching(changeWidget)},
      // {"title":RideDriverInfo.titleName,'widget':RideDriverInfo(changeWidget)},
    ];
    _currentWidget = states[widgetIndex];
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          _currentWidget['title'],
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white),
        )),
        body: _currentWidget['widget']
        // body: AnimatedSwitcher(
        //   duration: const Duration(seconds: 3),
        //   transitionBuilder: (Widget child, Animation<double> animation) =>
        //       SlideTransition(position: _animation, child: child),
        //   child: _currentWidget,
        // ),
        );
  }
}

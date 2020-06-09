// Flutter Material Components
import 'package:flutter/material.dart';
// Components
import 'package:clax/screens/MakeARide/Components/RideInfo.dart';

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
    // setState(() {
    //   _currentWidget = states[++widgetIndex % states.length];
    // });
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    _currentWidget = {
      "title": RideInfo.titleName,
      'widget': RideInfo(changeWidget)
    };
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
        body: _currentWidget['widget']);
  }
}

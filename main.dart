import 'package:flutter/material.dart';

void main() {
  // SystemChrome.setEnabledSystemUIOverlays([]); // Hide Notif. Toolbar
  // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values); // Show Notif. Toolbar
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}

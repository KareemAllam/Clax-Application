import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/forth');
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("Second"),
        ),
        body: Container(child: Text("Second")));
  }
}

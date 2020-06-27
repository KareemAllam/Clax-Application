import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Third"),
        ),
        body: Container(child: Text("Third")));
  }
}

class ForthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/fifth');
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text("Forth"),
        ),
        body: Container(child: Text("Forth")));
  }
}

class FifthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fifth"),
        ),
        body: Container(child: Text("Fifth")));
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class RealtimeDB extends StatefulWidget {
  @override
  _RealtimeDBState createState() => _RealtimeDBState();
}

class _RealtimeDBState extends State<RealtimeDB> {
  DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child("test");
  StreamSubscription<Event> event;
  int _counter = 0;
  String text = 'testing...';
  void pushNewChild() {
    _databaseReference.push().set({"firstname": "Kareem", 'Lastname': "Raid"});
  }

  void readOnce() async {
    DataSnapshot snapshot = await _databaseReference.orderByKey().once();
    var result = snapshot.value.values as Iterable;
    for (var item in result) {
      print(item);
    }
  }

  void readAsync() {
    event = _databaseReference.onValue.listen((event) {
      setState(() {
        text = event.snapshot.value ?? "0";
      });
    });
  }

  void cancelReadAsync() {
    event.cancel();
  }

  void updateChild() {
    _databaseReference.update({"value": ++_counter});
  }

  void setMainNode() {
    _databaseReference.set((++_counter).toString());
  }

  void deleteMainNode() {
    _databaseReference.remove();
  }

  @override
  void dispose() {
    super.dispose();
    event.cancel();
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: ListView(
            controller: new ScrollController(),
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            children: <Widget>[
              FlatButton(
                onPressed: pushNewChild,
                child: Text("Push new child with data"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
              FlatButton(
                onPressed: updateChild,
                child: Text("Update child with data"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
              FlatButton(
                onPressed: setMainNode,
                child: Text("Set Node Data"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
              FlatButton(
                onPressed: deleteMainNode,
                child: Text("Delete Node"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
              FlatButton(
                onPressed: readOnce,
                child: Text("Read Node Once"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
              FlatButton(
                onPressed: readAsync,
                child: Text("Read Node Async"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
              FlatButton(
                onPressed: cancelReadAsync,
                child: Text("Cancel Read Node Async"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
        Expanded(
          child: Text(text),
        )
      ],
    );
  }
}

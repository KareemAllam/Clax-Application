import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

class RealtimeDB {
  RealtimeDB() {
    _databaseRefrences = {};
    events = {};
  }
  // ==== Database Related Vars =====
  // Database-Connection
  Map<String, DatabaseReference> _databaseRefrences;
  // Database changes listener
  Map<String, StreamSubscription<Event>> events;
  // Static Data Vars
  int _counter = 0;
  String text = 'testing...';

  void pushNewChild(String child) {
    _databaseRefrences[child] =
        FirebaseDatabase.instance.reference().child(child);
    _databaseRefrences[child]
        .push()
        .set({"firstname": "Kareem", 'Lastname': "Raid"});
  }

  /// Reading a snapshot from firebase once.
  void readOnce(String child) async {
    _databaseRefrences[child] =
        FirebaseDatabase.instance.reference().child(child);
    DataSnapshot snapshot = await _databaseRefrences[child].orderByKey().once();
    var result = snapshot.value.values as Iterable;
    for (var item in result) {
      print(item);
    }
  }

  /// Reading a snapshot from firebase on value changed.
  void readAsync(String child, Function cb) {
    _databaseRefrences[child] =
        FirebaseDatabase.instance.reference().child(child);
    // print("Listening to child: $child");
    events[child] = _databaseRefrences[child].onValue.listen((event) {
      // code on event change
      cb(event.snapshot.value);
    });
  }

  /// Cancel reading asynchronously from db
  /// with specified child.
  void cancelReadAsync(String child) {
    // print("canceled successfully...");
    try {
      events[child].cancel();
    } catch (_) {}
    events[child] = null;
  }

  /// Updating the value of a specified child.
  void updateChild(String child, dynamic value) {
    _databaseRefrences[child] =
        FirebaseDatabase.instance.reference().child(child);
    _databaseRefrences[child].update({"value": ++_counter});
  }

  void setMainNode(String child, Map object) {
    _databaseRefrences[child] =
        FirebaseDatabase.instance.reference().child(child);
    _databaseRefrences[child].set(object);
  }

  /// Deleting a specified child.
  void deleteMainNode(String child) {
    _databaseRefrences.remove(child);
    FirebaseDatabase.instance.reference().child(child).remove();
  }

  void updateChildWRef(String child, Map object) {
    FirebaseDatabase.instance.reference().child(child).update(object);
  }

  get dbRefs => _databaseRefrences;
}

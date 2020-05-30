import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';

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

  void readOnce(String child) async {
    _databaseRefrences[child] =
        FirebaseDatabase.instance.reference().child(child);
    DataSnapshot snapshot = await _databaseRefrences[child].orderByKey().once();
    var result = snapshot.value.values as Iterable;
    for (var item in result) {
      print(item);
    }
  }

  void readAsync(String child, Function cb) {
    _databaseRefrences[child] =
        FirebaseDatabase.instance.reference().child(child);
    events[child] = _databaseRefrences[child].onValue.listen((event) {
      // code on event
      cb(event.snapshot.value);
    });
  }

  void cancelReadAsync(String child) {
    events[child].cancel();
    events[child] = null;
  }

  void updateChild(String child) {
    _databaseRefrences[child] =
        FirebaseDatabase.instance.reference().child(child);
    _databaseRefrences[child].update({"value": ++_counter});
  }

  void setMainNode(String child, Position position, int seats) {
    _databaseRefrences[child] =
        FirebaseDatabase.instance.reference().child(child);
    _databaseRefrences[child].set({
      "longitude": position.latitude,
      "latitude": position.longitude,
      'currentSeats': seats
    });
  }

  void deleteMainNode(String child) {
    _databaseRefrences.remove(child);
  }

  get dbRefs => _databaseRefrences;
}

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
  String text = 'testing...';

  void pushNewChild(String child) {
    _databaseRefrences[child] =
        FirebaseDatabase.instance.reference().child(child);
    _databaseRefrences[child]
        .push()
        .set({"firstname": "Kareem", 'Lastname': "Raid"});
  }

  /// Reading a snapshot from firebase once.
  Future<Map> readOnce(String child) async {
    _databaseRefrences[child] =
        FirebaseDatabase.instance.reference().child(child);
    DataSnapshot snapshot = await _databaseRefrences[child].once();
    return Map<String, dynamic>.from(snapshot.value);
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
  void updateChild(String child, Map value) {
    _databaseRefrences[child] =
        FirebaseDatabase.instance.reference().child(child);
    _databaseRefrences[child].update(Map<String, dynamic>.from(value));
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

  /// Deleting a specified child.
  void deleteMainNode(String child) {
    _databaseRefrences.remove(child);
  }

  get dbRefs => _databaseRefrences;
}

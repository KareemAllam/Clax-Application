import 'package:fcm_test/model.dart';
import 'package:flutter/material.dart';
// import 'package:fcm_test/fcmProvider.dart';
// import 'package:provider/provider.dart';

class PushMessagingExample extends StatefulWidget {
  @override
  _PushMessagingExampleState createState() => _PushMessagingExampleState();
}

class _PushMessagingExampleState extends State<PushMessagingExample> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Message> notifications = [];

    return Material(
      child: notifications.length == 0
          ? Center(child: Text("No Notifications yet"))
          : ListView.builder(
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              controller: new ScrollController(),
              itemCount: notifications.length,
              itemBuilder: (context, index) => ListTile(
                leading: Icon(
                  Icons.notifications,
                  size: 30,
                ),
                title: Text(notifications[index].title),
                subtitle: Text(notifications[index].body),
              ),
            ),
    );
  }
}

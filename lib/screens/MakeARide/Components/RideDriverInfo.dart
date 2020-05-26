import 'package:flutter/material.dart';

class RideDriverInfo extends StatefulWidget {
  final Function changeWidget;
  RideDriverInfo(this.changeWidget);
  @override
  _RideDriverInfoState createState() => _RideDriverInfoState();
}

class _RideDriverInfoState extends State<RideDriverInfo> {
  Map<String, dynamic> dummpyData = {
    "driver_info": {
      "name": {"first": "John", "last": "sayed"},
      "img": "www.google.com/driver.png",
      "_id": "5e5690b3e781d4395c633b44",
      "phone": "01258963485"
    },
    "car": {"color": "red", "number": "123"}
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(children: <Widget>[
        Text("asd"),
      ]),
    );
  }
}

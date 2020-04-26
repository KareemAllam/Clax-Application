import 'package:flutter/material.dart';

class NullContent extends StatelessWidget {
  final String things;
  NullContent({this.things = "محتوى"});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 0.5, color: Colors.grey)],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          child: Text('لا يوجد اي $things'),
        ),
      ],
    );
  }
}

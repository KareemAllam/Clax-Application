import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TakeABreak extends StatelessWidget {
  final Function changeState;
  TakeABreak(this.changeState);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(FontAwesomeIcons.coffee, color: Colors.grey),
          SizedBox(height: 8),
          RaisedButton(
              elevation: 0,
              highlightElevation: 0,
              onPressed: changeState,
              child:
                  Text("عودة إلى العمل", style: TextStyle(color: Colors.white)),
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
        ],
      ),
    );
  }
}

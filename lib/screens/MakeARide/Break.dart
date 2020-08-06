import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TakeABreak extends StatelessWidget {
  final Function changeState;
  TakeABreak(this.changeState);
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      GestureDetector(
        onTap: () => changeState(true),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(FontAwesomeIcons.coffee, color: Colors.grey),
            SizedBox(height: 16),
            RaisedButton(
                elevation: 0,
                highlightElevation: 0,
                onPressed: null,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                disabledColor: Theme.of(context).primaryColor,
                child: Text("عودة إلى العمل",
                    style: TextStyle(color: Colors.white)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
          ],
        ),
      ),
    ]);
  }
}

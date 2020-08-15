// Flutter Material Components
import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, {Widget text, Function cb}) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("الغاء",
        style: TextStyle(
            color: Colors.white60,
            fontWeight: FontWeight.bold)), // Dismiss the Alert Dialoge Box
    onPressed: Navigator.of(context).pop,
  );

  Widget continueButton = FlatButton(
    child: Text("نعم",
        style: TextStyle(
            color: Theme.of(context).accentColor, fontWeight: FontWeight.bold)),
    onPressed: cb == null
        ? () {
            Navigator.pop(context);
          }
        : () {
            cb();

            Navigator.pop(context);
          },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    title: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5), topRight: Radius.circular(5))),
        padding: EdgeInsets.only(top: 20, right: 15, left: 15, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "هل تريد متابعه طلبك؟",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontWeight: FontWeight.values[5]),
            ),
            SizedBox(height: 2),
            text
          ],
        )),
    buttonPadding: EdgeInsets.all(0),
    actionsPadding: EdgeInsets.all(0),
    titlePadding: EdgeInsets.all(0),
    contentPadding: EdgeInsets.all(0),
    content: Container(
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            continueButton,
            cancelButton,
          ],
        )),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

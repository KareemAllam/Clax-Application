import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, {Widget text, Function cb}) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 20),
    child: Text("لا",
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700)),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = FlatButton(
    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 20),
    child: Text("نعم",
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700)),
    onPressed: () {
          cb();
          Navigator.pop(context);
        } ??
        () {
          Navigator.pop(context);
        },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    titlePadding: EdgeInsets.all(0),
    title: Container(
      child: Row(children: [
        Icon(Icons.feedback, color: Colors.white),
        SizedBox(width: 10),
        Text("تأكيد",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontWeight: FontWeight.w700, color: Colors.white))
      ]),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    content: text ??
        Text(
          "هل انت متاكد من...؟",
          style: Theme.of(context).textTheme.bodyText2,
        ),
    buttonPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
    actionsPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

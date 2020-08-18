import 'package:flutter/material.dart';

oneButtonAlertDialoge(BuildContext context,
    {String title, String description, Function cb}) {
  // set up the buttons
  Widget continueButton = FlatButton(
    child: Text("حسنا",
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
            Text(title,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.values[5], color: Colors.black87)),
            SizedBox(height: 2),
            if (description != null)
              Text(description,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.grey))
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
          ],
        )),
  );

  // show the dialog
  showDialog(
    useRootNavigator: true,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future<bool> keepWorkingAlert(BuildContext context, {String lineName}) {
  // set up the buttons
  Widget continueButton = FlatButton(
      child: Text("نعم",
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold)),
      onPressed: () {
        Navigator.pop(context, true);
      });

  Widget cancelButton = FlatButton(
      child: Text("انهي الرحلة",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
      onPressed: () {
        Navigator.pop(context, false);
      });

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
            Text("لقد كنت على طريق $lineName منذ قليل",
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.values[5], color: Colors.black87)),
            SizedBox(height: 2),
            Text("اتريد الاستمرار في رحلتك؟",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.grey))
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
          children: <Widget>[continueButton, cancelButton],
        )),
  );

  // show the dialog
  return showDialog<bool>(
    useRootNavigator: true,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

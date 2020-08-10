// Dart & Other Packages
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Screens
import 'package:clax/screens/MakeARide/widgets/FlipIcon.dart';
// Widgets
import 'package:clax/screens/MakeARide/GoogleMap.dart';
// Providers
import 'package:clax/providers/Map.dart';
// Drawer
import 'package:clax/screens/Drawer.dart';

class OnATrip extends StatefulWidget {
  @override
  _OnATripState createState() => _OnATripState();
}

class _OnATripState extends State<OnATrip> {
  showAlertDialog() {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("رجوع",
          style: TextStyle(
              color: Colors.white60,
              fontWeight: FontWeight.bold)), // Dismiss the Alert Dialoge Box
      onPressed: Navigator.of(context).pop,
    );

    Widget continueButton = FlatButton(
      child: Text("نعم",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
      onPressed: () {
        Provider.of<MapProvider>(context, listen: false).cancelOngoingTrip();
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
          padding: EdgeInsets.only(top: 20, right: 15, left: 15, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.report_problem,
                        color: Theme.of(context).accentColor),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text("هل تريد الغاء الرحلة ؟",
                          strutStyle: StrutStyle(forceStrutHeight: true),
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                  ]),
              SizedBox(height: 4),
              Text("سيتم خصم سعر الرحلة من حسابك عند الغاء الرحلة",
                  strutStyle: StrutStyle(),
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
              cancelButton,
            ],
          )),
    );

    // show the dialog
    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('تابع رحلتك',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white)),
        ),
        drawer: MainDrawer(),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FlipCard(),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    elevation: 0,
                    highlightElevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () {
                      Navigator.of(context).pushNamed(MapPage.routeName);
                    },
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      "تتبع رحلتك",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 8),
                  RaisedButton(
                      elevation: 0,
                      highlightElevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      color: Colors.red,
                      onPressed: () => showAlertDialog(),
                      child: Text("الغاء الرحلة",
                          style: TextStyle(color: Colors.white)))
                ],
              )
            ],
          ),
        ));
  }
}

// Flutter's Material Components
import 'package:flutter/material.dart';
// Screens
import 'package:clax/screens/MakeARide/StartTrip.dart';
// Widgets
import 'package:clax/widgets/FormInput.dart';
import 'package:clax/widgets/LoadingButton.dart';
// Main Drawer

class TripEnded extends StatefulWidget {
  static const routeName = "/tripEnded";
  @override
  _TripEndedState createState() => _TripEndedState();
}

class _TripEndedState extends State<TripEnded> {
  TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _feedbackController.dispose();
  }

  void endTrip() {
    // TODO: Add feedback sysmtem to driver
    // Return to StartTrip
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed(StartTrip.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('انتهت الرحلة',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white)),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("انتهت الرحلة بنجاح",
                style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 16),
            FormInput(
                title: "علق على الرحلة",
                placeholder: "هل حدث اي مشكلة في الرحلة؟",
                description: _feedbackController),
            SizedBox(height: 24),
            LoadingButton(
              label: "قدم شكوى",
              handleTap: endTrip,
            ),
          ],
        ),
      ),
    );
  }
}

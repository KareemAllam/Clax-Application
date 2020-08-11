// Flutter's Material Components
import 'package:flutter/material.dart';
// Widgets
import 'package:clax/widgets/FormInput.dart';

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
    // Return to StartTrip
    Navigator.of(context).pop();
    // Navigator.of(context).pushReplacementNamed(StartTrip.routeName);
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 16),
            FormInput(
                title: "علق على الرحلة",
                placeholder: "هل حدث اي مشكلة في الرحلة؟",
                description: _feedbackController),
            Spacer(),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: endTrip,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      alignment: Alignment.center,
                      color: Theme.of(context).primaryColor,
                      child: Text("متابعه",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: endTrip,
                    child: Container(
                      padding: EdgeInsets.all(12),
                      alignment: Alignment.center,
                      color: Colors.red,
                      child: Text("قدم شكوى",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(color: Colors.white)),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

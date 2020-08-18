// Dart & Other Packages
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Flutter Material Components
import 'package:flutter/material.dart';
// Providers
import 'package:clax/providers/Profile.dart';
// Screens
import 'package:clax/screens/Login/Verification.dart';

class TakeABreak extends StatefulWidget {
  final Function authenticatedUser;
  TakeABreak(this.authenticatedUser);
  @override
  _TakeABreakState createState() => _TakeABreakState();
}

class _TakeABreakState extends State<TakeABreak> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      GestureDetector(
        onTap: () {
          // Logic: Prevents the user from using the app
          bool phoneVerified =
              Provider.of<ProfilesProvider>(context, listen: false)
                  .profile
                  .phoneVerified;
          if (phoneVerified)
            widget.authenticatedUser(true);
          else
            Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Theme.of(context).primaryColor,
                action: SnackBarAction(
                    label: "تفعيل",
                    onPressed: () => Navigator.of(context)
                        .pushNamed(Verification.routeName)),
                content: Text("برجاء تفعيل هاتفك اولاًَ.",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(color: Colors.white))));
        },
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

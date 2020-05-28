// Flutter's Material Components
import 'package:flutter/material.dart';

class FamilyPreview1 extends StatelessWidget {
  final Function changeWidget;
  FamilyPreview1(this.changeWidget);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 10),
        Image.asset(
          'assets/images/parents.jpg',
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
          child: Text(
            'تتبع رحلات عائلتك في اي وقت',
            style: TextStyle(
              fontSize: 24,
              color: Colors.black87,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            'قم معرفة مكان عائلتك و معلومات اخرى عن رحلاتهم في اي وقت مع كلاكس',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Colors.grey),
          ),
        ),
        Spacer(flex: 5),
        RaisedButton(
          child: Text(
            'متابعة',
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 60,
          ),
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          onPressed: changeWidget,
        ),
        Spacer(flex: 1)
      ],
    );
  }
}

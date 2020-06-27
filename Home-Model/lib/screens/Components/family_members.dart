import 'package:clax/widgets/appBar.dart';
import 'package:flutter/material.dart';

import '../Members.dart';

class FamilyMembers extends StatelessWidget {
  static const routeName = '/family_members';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context, 'أفراد العائلة'),
        body: Container(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/images/children.png'),
              SizedBox(height: 15),
              Text(
                'قم بدعوة أفراد العائلة إلى كلاكس.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black87,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Spacer(flex: 5),
              RaisedButton(
                child: Text(
                  'دعوة العائلة',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.00),
                  side: BorderSide(
                    width: 1.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: MediaQuery.of(context).size.width / 4,
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(Members.routeName);
                },
              ),
              Spacer()
            ],
          ),
        ));
  }
}

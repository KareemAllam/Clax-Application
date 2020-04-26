// Flutter's Material Components
import 'package:flutter/material.dart';
// Components
import 'package:clax/screens/Home/Components/family_members.dart';
// Widgets
import 'package:clax/widgets/appBar.dart';

class Family extends StatelessWidget {
  static const routeName = '/Family';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: buildAppBar(context, 'العائلة'),
        body: Container(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/parents.jpg',
              ),
              SizedBox(height: 20),
              // Spacer(flex: 1),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                child: Column(children: <Widget>[
                  Text(
                    'يمكنك تتبع رحلات أفراد عائلتك',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black87,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'يمكنك إضافة أفراد العائلة حتى تتمكن من تتبعهم بأمان ، سوف تصلك الإشعارات عند بداية الرحلة.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black45,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ]),
              ),
              // SizedBox(height: 250),
              Spacer(flex: 5),
              RaisedButton(
                child: Text(
                  'إضافة',
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
                  horizontal: width / 4.0,
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(FamilyMembers.routeName);
                },
              ),
              Spacer(flex: 1)
            ],
          ),
        ));
  }
}

// Flutter's Material Components
import 'package:flutter/material.dart';
// Screens
import 'package:clax/screens/Settings/Components/Members.dart';

class FamilyPreview2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset('assets/images/children.png'),
        SizedBox(height: 15),
        Text(
          'ادعو أفراد عائلتك إلى كلاكس.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            color: Colors.black87,
            fontWeight: FontWeight.w800,
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'يمكنك إضافة أفراد عائلتك حتى تتمكن من تتبعهم بأمان.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2,
            )),
        Spacer(flex: 1),
        Text(
          ' سوف تصلك الإشعارات عند بداية الرحلة',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/images/logo.png'),
              ),
              title: Text(
                "كلاكس",
                strutStyle: StrutStyle(forceStrutHeight: true),
                style: Theme.of(context).textTheme.subtitle2,
              ),
              subtitle: Text(
                "بدء احمد رحلة جديدة. اضغط لتعرف المزيد",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.grey),
              ),
            )),
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
    );
  }
}

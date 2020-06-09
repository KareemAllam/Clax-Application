// Flutter's Material Components
import 'package:flutter/material.dart';
// Screens
import 'package:clax/screens/Settings/Family.dart';

class FamilyPreview2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
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
            padding: EdgeInsets.symmetric(horizontal: _width * 0.15),
            child: Text(
              'يمكنك إضافة أفراد عائلتك حتى تتمكن من تتبعهم بأمان في اي وقت و اي مكان.',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.grey),
            )),
        Spacer(flex: 1),
        Text(
          ' سوف تصلك الإشعارات عند بداية الرحلة',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
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
              ),
            ),
            Align(
              alignment: Alignment(-0.8, 0),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1)),
                child: Text(
                  "1",
                  style: Theme.of(context).textTheme.caption.copyWith(
                      fontFamily: "Product Sans",
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        Spacer(flex: 2),
        GestureDetector(
          onTap: () =>
              Navigator.of(context).pushReplacementNamed(Members.routeName),
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              color: Theme.of(context).primaryColor,
              alignment: Alignment.center,
              width: double.infinity,
              child: Text('دعوة العائلة',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold))),
        )
      ],
    );
  }
}

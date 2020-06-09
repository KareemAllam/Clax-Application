// Flutter's Material Components
import 'package:flutter/material.dart';

class FamilyPreview1 extends StatelessWidget {
  final Function changeWidget;
  FamilyPreview1(this.changeWidget);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            flex: 2,
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(right: 10.0, top: 5),
                child: Text('تتبع رحلات عائلتك في اي وقت',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  'قم معرفة مكان عائلتك و معلومات اخرى عن رحلاتهم في اي وقت مع كلاكس',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(color: Colors.grey),
                ),
              )
            ])),
        Expanded(
            flex: 9,
            child: Image.asset(
              'assets/images/map2.png',
              alignment: Alignment(0, -0.2),
              width: double.infinity,
              fit: BoxFit.fitWidth,
              // scale: 2,
            )),
        Expanded(
            child: GestureDetector(
          onTap: changeWidget,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10),
            color: Theme.of(context).primaryColor,
            width: double.infinity,
            child: Text(
              'متابعة',
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        )),
      ],
    );
  }
}

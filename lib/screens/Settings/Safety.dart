// Flutter's Material Components
import 'package:flutter/material.dart';
// Components
// import 'package:clax/screens/Settings/TrustedContacts.dart';

class Safety extends StatelessWidget {
  static const routeName = '/Safety';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('الأمان',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white)),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/contacts.jpg'),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: <Widget>[
                  Text('يمكنك إضافة أشخاص تثق بهم ',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.black87)),
                ],
              ),
            ),
            Container(
              child: Text(
                  'عند إضافة الأشخاص ، سوف تصلهم الإشعارات مع بداية رحلتك. \n سيتمكنون من تتبعك في اي  لحظة اثناء رحلاتك',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(color: Colors.black54)),
            ),
            Spacer(),
            Builder(
              builder: (context) => RaisedButton(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'إضافة',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(color: Colors.white),
                  ),
                  width: double.infinity,
                  height: 50,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 4,
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      content: Text(
                        "لم يتم الانتهاء من هذه الخاصية بعد",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

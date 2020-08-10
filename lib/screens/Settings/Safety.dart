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
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'يمكنك إضافة أشخاص تثق بهم ',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black87,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'عند إضافة الأشخاص ، سوف تصلهم الإشعارات مع بداية رحلتك.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black45,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 18),
                RaisedButton(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'إضافة',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    width: 175,
                    height: 50,
                  ),
                  // shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(20.00),
                  //   side: BorderSide(
                  //     width: 1.0,
                  //     color: Theme.of(context).primaryColor,
                  //   ),
                  // ),
                  padding: EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 4,
                  ),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        backgroundColor: Theme.of(context).primaryColor,
                        content: Text(
                          "لم يتم الانتهاء منها بعد",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(color: Colors.white),
                        )));
                  },
                )
              ],
            )));
  }
}

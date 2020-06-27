import 'package:clax/providers/profiles.dart';
import 'package:clax/models/profile.dart';
import 'package:clax/screens/verification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Account.dart';
import '../utils/password.dart';

class YourAccount extends StatelessWidget {
  static const routeName = '/yourAcc';

  @override
  Widget build(BuildContext context) {
    final Profile profileData =
        Provider.of<Profiles>(context, listen: false).profile;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'حسابك الشخصي',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(Account.routeName);
              },
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                Provider.of<Profiles>(context, listen: false).init();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 20,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: Icon(
                        Icons.person_outline,
                        size: 22,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('الأسم ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                          fontSize: 18, color: Colors.black54)),
                              Text(
                                profileData.name.first ??
                                    "" + " " + profileData.name.last ??
                                    "",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      fontSize: 18,
                                    ),
                              ),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 20,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: Icon(
                        Icons.phone_android,
                        size: 22,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('رقم الموبايل',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(
                                              fontSize: 18,
                                              color: Colors.black54)),
                                  Text(
                                    profileData.phone,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .copyWith(
                                          fontSize: 18,
                                        ),
                                  ),
                                ]),
                            profileData.phoneVerified
                                ? Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                : IconButton(
                                    icon: Icon(Icons.close, color: Colors.red),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              EVerify.routeName,
                                              arguments: {
                                            'phone': profileData.phone,
                                            'route': "/yourAcc"
                                          });
                                    })
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 20,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: Icon(
                        Icons.email,
                        size: 22,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('البريد الإلكتروني',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                          fontSize: 18, color: Colors.black54)),
                              Text(
                                profileData.mail,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      fontSize: 18,
                                    ),
                              ),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 20,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: Icon(
                        Icons.lock_outline,
                        size: 22,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('كلمة المرور',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                        fontSize: 18,
                                        color: Colors.black54,
                                      )),
                              Text(password(profileData.passLength),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(
                                        fontSize: 22,
                                      )),
                            ]),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
            ],
          ),
        ));
  }
}

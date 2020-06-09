// Dart & Other Packages
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Utils
import 'package:clax/utils/password.dart';
// Models
import 'package:clax/models/Profile.dart';
// Providers
import 'package:clax/providers/Profile.dart';
// Screens
import 'package:clax/screens/Login/Verification.dart';
// Components
import 'package:clax/screens/Settings/EditAccount.dart';

class AccountOverview extends StatefulWidget {
  static const routeName = '/yourAcc';

  @override
  _AccountOverviewState createState() => _AccountOverviewState();
}

class _AccountOverviewState extends State<AccountOverview> {
  bool _refreshing = false;
  @override
  Widget build(BuildContext context) {
    ProfileModel profileData = Provider.of<ProfilesProvider>(context).profile;
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
              icon: _refreshing
                  ? SpinKitThreeBounce(color: Colors.white, size: 12)
                  : Icon(Icons.refresh),
              onPressed: () async {
                setState(() {
                  _refreshing = true;
                });
                await Provider.of<ProfilesProvider>(context, listen: false)
                    .init();
                setState(() {
                  _refreshing = false;
                });
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: profileData.name == null
              ? Center(
                  child: SpinKitCircle(color: Theme.of(context).primaryColor),
                )
              : Column(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                                            .copyWith(color: Colors.black54)),
                                    Text(
                                      profileData.name.first +
                                          " " +
                                          profileData.name.last,
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
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('رقم الموبايل',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .copyWith(
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
                                          icon: Icon(Icons.close,
                                              color: Colors.red),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                              Verification.routeName,
                                            );
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
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                                            .copyWith(color: Colors.black54)),
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
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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

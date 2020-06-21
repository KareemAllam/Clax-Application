// Dart & Other Packages
import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Providers
import 'package:clax/providers/Payment.dart';
import 'package:clax/providers/Profile.dart';
// Models
import 'package:clax/models/Profile.dart';
// Screens
import 'package:clax/screens/Login/Verification.dart';

class PaymentAppBarBottom extends StatefulWidget {
  @override
  _PaymentAppBarBottomState createState() => _PaymentAppBarBottomState();
}

class _PaymentAppBarBottomState extends State<PaymentAppBarBottom> {
  _PaymentAppBarBottomState();
  String urll = "error";
  ProfileModel _profile;

  Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _profile = Provider.of<ProfilesProvider>(context).profile;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    return _profile == null
        ? SpinKitCircle(color: Colors.white)
        : Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Consumer<PaymentProvider>(
              builder: (context, account, child) => Text(
                account.balance.toString(),
                style: TextStyle(
                    fontSize: width * 0.15,
                    fontFamily: 'Product Sans',
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Builder(
              builder: (context) => Material(
                borderRadius: BorderRadius.all(Radius.circular(width)),
                color: theme.accentColor,
                elevation: 2.0,
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(width)),
                  splashColor: Colors.orange,
                  onTap: () async {
                    bool result = await checkInternet();
                    if (result) {
                      if (_profile.phoneVerified) {
                        showModalBottomSheet<bool>(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            backgroundColor: Colors.transparent,
                            // isScrollControlled: true,
                            isDismissible: true,
                            builder: (BuildContext context) {
                              return Text("tbd");
                            });
                      } else
                        Scaffold.of(context).showSnackBar(SnackBar(
                            backgroundColor: theme.primaryColor,
                            action: SnackBarAction(
                                label: "تفعيل",
                                onPressed: () => Navigator.of(context)
                                    .pushNamed(Verification.routeName)),
                            content: Text("برجاء تفعيل هاتفك اولاًَ.",
                                style: theme.textTheme.subtitle2
                                    .copyWith(color: Colors.white))));
                    } else
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "تعذر الوصول للإنترنت. تأكد من اتصالك بالإنترنت و حاول مره اخرى.",
                              style: theme.textTheme.caption
                                  .copyWith(color: Colors.white))));
                  },
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: width * 0.8),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                      child: Text(
                        "اضافة المزيد",
                        style: theme.textTheme.button.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]);
  }
}

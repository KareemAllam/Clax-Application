// Dart & Other Packages
import 'dart:async';
import 'package:http/http.dart';
import 'package:pin_view/pin_view.dart';
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// Backend
import 'package:clax/services/Backend.dart';
// Providers
import 'package:clax/providers/Profiles.dart';

class Verification extends StatefulWidget {
  static const routeName = '/verification';
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  bool counting = false;
  bool _enabled = true;
  String _code;
  String _userCode;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void startTimer() {
    setState(() {
      counting = true;
    });

    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        counting = false;
      });
    });
  }

  void getCode() async {
    String phone =
        Provider.of<ProfilesProvider>(context, listen: false).profile.phone;
    Map<String, String> body = {"phone": phone};
    Response response =
        await Api.post('passengers/settings/phone-verification', body);
    _code = response.body;
    print(_code);
  }

  void validateCode() async {
    // Disabling "re-send code" button
    setState(() {
      _enabled = false;
    });

    // If User's Code is correct
    if (_userCode == _code) {
      // Send back to the server
      await Api.put("passengers/settings/phone-verification");

      // Change Current State
      bool result = await Provider.of<ProfilesProvider>(context, listen: false)
          .verifyPhone();

      // If internet connection went off
      if (!result)
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(
              ".تأكد من اتصالك بالانترنت و حاول مره اخرى",
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.white),
            ),
            backgroundColor: Colors.red));
      else {
        Navigator.of(context).pop();
      }
    }

    // If User's Code is incorrect
    else
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            ".تأكد من الكود الخاص بك و حاول مره اخرى",
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.red));
    // print("Code Not Valid");

    setState(() {
      _enabled = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getCode();
  }

  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color purple = theme.primaryColor;
    TextTheme textTheme = theme.textTheme;

    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    color: purple,
                    padding: EdgeInsets.only(top: 20),
                    height: 250,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/phone.gif',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30, right: 5),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  )
                ],
              ),
              Spacer(flex: 1),
              Text("اكتب رمز التأكيد الخاص بك",
                  style: textTheme.headline6
                      .copyWith(fontWeight: FontWeight.bold, color: purple)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: PinView(
                    enabled: _enabled,
                    inputDecoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        filled: true,
                        fillColor: Colors.white),
                    sms: SmsListener(
                        from:
                            '01024839987', // address that the message will come from
                        formatBody: (String body) {
                          print(body);
                          // incoming message type
                          // from: "6505551212"
                          // body: "Your verification code is: 123-456"
                          // with this function, we format body to only contain
                          // the pin itself
                          String codeRaw = body.split(": ")[1];
                          List<String> code = codeRaw.split("-");
                          return code.join(); // 341430
                        }),
                    count: 6, // describes the field number
                    autoFocusFirstField: true, // defaults to true
                    margin: EdgeInsets.symmetric(
                        horizontal: 10), // margin between the fields
                    style: textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.w500,
                        fontFamily: "Product Sans"),
                    dashStyle: TextStyle(
                        // dash style
                        fontSize: 20.0,
                        color: Colors.grey),
                    submit: (String pin) {
                      _userCode = pin;
                    }),
              ),
              Spacer(flex: 8),
              Builder(
                builder: (context) => Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: RaisedButton(
                    textColor: Theme.of(context).hintColor,
                    onPressed: validateCode,
                    highlightElevation: 0.1,
                    elevation: 1,
                    shape: StadiumBorder(),
                    color: purple,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                    child: Text(
                      "تسجيل",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              counting
                  ? Text(
                      "تم ارسال رساله لهاتفك.",
                      style:
                          textTheme.subtitle2.copyWith(color: Colors.black54),
                    )
                  : RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "لم تصلك رساله بعد؟",
                            style: textTheme.subtitle2
                                .copyWith(color: Colors.black54)),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                startTimer();
                                getCode();
                              },
                            text: " اضغط هنا",
                            style: textTheme.subtitle2.copyWith(
                                color: purple, fontWeight: FontWeight.w600))
                      ]),
                    ),
              Spacer(flex: 2),
            ]),
          ),
        ),
      ),
    );
  }
}

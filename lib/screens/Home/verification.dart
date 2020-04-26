// Dart & Other Packages
import 'dart:convert';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
// Flutter's Material Components
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Providers
import 'package:clax/providers/profiles.dart';
// Utils
import 'package:clax/services/Backend.dart';
// Components
//import 'package:clax/screens/yourAcc.dart';
// Widgets
import 'package:clax/widgets/appBar.dart';

class EVerify extends StatefulWidget {
  static const routeName = '/verification';
  @override
  _EVerifyState createState() => _EVerifyState();
}

class _EVerifyState extends State<EVerify> {
  /*..text = 'clax97'*/
  TextEditingController pinCode = TextEditingController();
  bool hasError = false;
  String currentText = "";
  var code = 123456;
  void getCode(phone) async {
    Response result = await Api.post(
        "passengers/settings/phone-verification", {'phone': phone});
    if (result.statusCode == 200) {
      setState(() {
        code = json.decode(result.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> settings = ModalRoute.of(context).settings.arguments;
    String route = settings['route'];
    String phone = Provider.of<Profiles>(context, listen: false).profile.phone;
    GestureRecognizer onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        getCode(phone);
        // Navigator.of(context).pushReplacementNamed(route);
      };
    // getCode();

    var result = Provider.of<Profiles>(context);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: buildAppBar(context, 'كود التحقق'),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/abcd.jpg',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'التحقق من رقم الهاتف',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black87,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'يرجى إدخال الكود المرسل إلى الرقم:',
                      children: [
                        TextSpan(
                            text: phone,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ],
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black45,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21),
                    child: PinCodeTextField(
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                      controller: pinCode,
                      textInputType: TextInputType.number,
                      length: 6,
                      obsecureText: false,
                      animationType: AnimationType.fade,
                      shape: PinCodeFieldShape.underline,
                      animationDuration: Duration(milliseconds: 500),
                      borderRadius: BorderRadius.circular(15),
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      selectedColor: Theme.of(context).primaryColor,
                      fieldHeight: 35,
                      fieldWidth: 20,
                      onChanged: (value) {
                        setState(() {
                          currentText = value;
                        });
                      },
                      dialogTitle: 'نسخ الكود المرسل',
                      dialogContent: 'هل تود نسخ الكود المرسل إليك',
                      affirmativeText: 'نسخ',
                      negativeText: 'إلغاء',
                    ),
                  ),
                  SizedBox(height: 15),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: 'لم يصل كود التحقق بعد:  ',
                        style: TextStyle(color: Colors.black54, fontSize: 15),
                        children: [
                          TextSpan(
                              text: 'إعادة الإرسال',
                              recognizer: onTapRecognizer,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18))
                        ]),
                  ),
                  SizedBox(
                    height: 55,
                  ),
                  Builder(
                    builder: (context) => RaisedButton(
                      child: Text(
                        'تم',
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
                        horizontal: MediaQuery.of(context).size.width / 4.0,
                      ),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () async {
                        if (currentText.length != 6) {
                          setState(() {
                            hasError = true;
                          });
                        } else {
                          print(currentText);
                          print(code.toString());
                          if (currentText == code.toString()) {
                            bool verification = await result.verifyPhone();
                            if (verification)
                              Navigator.of(context).pushReplacementNamed(route);
                            else
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "انت غير متصل بالإنترنت.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              );
                          } else
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "هذا الكوه غير صحيح. تأكد من الكود الخاص بك و حاول مره اخرى .",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            );
                        }
                      },
                    ),
                  )
                ],
              )),
        ));
  }
}

// Dart & Other Packages
// import 'package:toast/toast.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Services
import 'package:flutter/services.dart';
// Screens
// import 'package:clax/screens/Login_Screens/resetPassword.dart';

class ForgetPass extends StatefulWidget {
  static const routeName = '/resetPassword';
  @override
  _ForgetPassState createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  TextEditingController _usernameController = TextEditingController();
  FocusNode _usernameNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  RegExp email = RegExp(
      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");
  RegExp phone = RegExp(r'^[0-9]+$');
  RegExp phoneEgypt = RegExp(r'^01[0125][0-9]{8}$');
  void verifyUsername() {
    if (_formKey.currentState.validate()) {
      // If the form is valid
      Navigator.pushNamed(context, "/verification");
    }
    print(_usernameController.text);
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _usernameNode.dispose();
  }

  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color purple = theme.primaryColor;
    TextTheme textTheme = theme.textTheme;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: SingleChildScrollView(
        child: Container(
            width: double.infinity,
            height: height,
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                            color: purple,
                            padding: EdgeInsets.only(top: 20),
                            height: 220,
                            width: double.infinity,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text(
                                    "لديك مشكلة في الوصول لبياناتك؟",
                                    style: textTheme.headline6.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )),
                                Expanded(
                                    child: Image.asset(
                                  'assets/images/lock.png',
                                  height: 150,
                                  fit: BoxFit.fitHeight,
                                ))
                              ],
                            )),
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
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: <Widget>[
                          // Email
                          TextFormField(
                            autocorrect: true,
                            validator: (value) {
                              value = value.trim();
                              print(value);
                              // Empte Textfield
                              if (value.isEmpty) {
                                return 'ادخل رقم الهاتف / البريد الالكتروني الخاص بك';
                              }
                              // User Entered a Phone Number
                              else if (phone.hasMatch(value)) {
                                print("phone match");
                                // Wrong number of numbers.
                                if (value.length != 11)
                                  return 'تأكد من ادخال رقمك بشكل صحيح.';
                                // Everything is good
                                if (phoneEgypt.hasMatch(value)) return null;
                                // Wrong Phone Number Format
                                return 'هذا الرقم غير صحيح. تأكد من الرقم و حاول مره اخرى.';
                              }
                              // User Entered wrong information
                              else if (!email.hasMatch(value)) {
                                return "تأكد من ادخال بياناتك بشكل صحيح";
                              }
                              // User Entered a valid mail
                              else {
                                return null;
                              }
                            },
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(
                                    fontFamily: "Product Sans",
                                    fontWeight: FontWeight.w600),
                            textInputAction: TextInputAction.next,
                            focusNode: _usernameNode,
                            cursorColor: Theme.of(context).primaryColor,
                            controller: _usernameController,
                            onFieldSubmitted: (_) {
                              _usernameNode.unfocus();
                              verifyUsername();
                            },
                            decoration: InputDecoration(
                              filled: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              fillColor: Colors.white,
                              prefixIcon: Icon(
                                Icons.person_outline,
                              ),
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Colors.grey),
                              labelText: 'رقم الهاتف / البريد الالكتروني',
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(top: 10),
                            width: double.infinity,
                            child: RaisedButton(
                              onPressed: verifyUsername,
                              shape: StadiumBorder(),
                              color: purple,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 5),
                              child: Text(
                                "ارسال",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))),
      ),
    ));
  }
}

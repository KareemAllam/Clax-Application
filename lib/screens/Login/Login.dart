// Dart & Other Packages
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Utils
import 'package:clax/services/Backend.dart';
// Providers
import 'package:clax/providers/Auth.dart';
// Screens
import 'package:clax/screens/ClaxRoot.dart';
import 'package:clax/screens/Login/ForgotPassword.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  bool _loading = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode _usernameNode = FocusNode();
  FocusNode _passwordNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  RegExp email = RegExp(
      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");
  RegExp phone = RegExp(r'^[0-9]+$');
  RegExp phoneEgypt = RegExp(r'^01[0125][0-9]{8}$');

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameNode.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  Future<String> submitform(firebaseToken) async {
    setState(() {
      _loading = true;
    });
    if (_formKey.currentState.validate()) {
      // Authenticate From Server
      Map<String, String> body = {
        "user": _usernameController.text.trim(),
        "pass": _passwordController.text,
        "fireBaseId": firebaseToken
      };
      Response response = await Api.post('signing/passengers/login', body);
      setState(() {
        _loading = false;
      });
      if (response.statusCode == 200) {
        //  Update Cache with id
        Provider.of<AuthProvider>(context, listen: false)
            .logIn(response.headers['x-login-token']);

        Navigator.of(context).pushReplacementNamed(ClaxRoot.routeName);
        return "_";
      }
      // If Server Erros Occured
      else {
        return "تأكد من اتصالك بالإنترنت و حاول مره اخرى.";
      }
    }
    // If there is no Internet Connection
    else {
      setState(() {
        _loading = false;
      });
      return "تاكد من معلوماتك و حاول مرة اخرى.";
    }
  }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final ThemeData theme = Theme.of(context);
    final String firebaseToken = Provider.of<AuthProvider>(context).fbToken;

    return Scaffold(
      body: WillPopScope(
        onWillPop: () => Future.value(false),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: height * 0.4,
                        alignment: Alignment.centerRight,
                        child: RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(children: [
                              TextSpan(
                                text: "مرحبا بك",
                                style: theme.textTheme.headline3.copyWith(
                                    height: 1.4,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w800),
                              ),
                              TextSpan(
                                text: "\nفي كلاكس",
                                style: theme.textTheme.headline3.copyWith(
                                    height: 1.4,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w800),
                              ),
                              TextSpan(
                                text: ".",
                                style: theme.textTheme.headline3.copyWith(
                                    height: 1.4,
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.w800),
                              ),
                            ])),
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                autocorrect: true,
                                validator: (value) {
                                  value = value.trim();
                                  // Empte Textfield
                                  if (value.isEmpty) {
                                    return 'ادخل رقم الهاتف / البريد الالكتروني الخاص بك';
                                  }
                                  // User Entered a Phone Number
                                  else if (phone.hasMatch(value)) {
                                    // Wrong number of numbers.
                                    if (value.length != 11)
                                      return 'تأكد من ادخال رقمك بشكل صحيح.';
                                    // Everything is good
                                    if (phoneEgypt.hasMatch(value)) return null;
                                    // Wrong Phone Number Format
                                    return 'هذا الرقم غير صحيح. تأكد من الرقم و حاول مره اخرى.';
                                  }
                                  // User Entered wrong information
                                  else if (!email
                                      .hasMatch(value.toLowerCase())) {
                                    return "تأكد من ادخال بياناتك بشكل صحيح";
                                  }
                                  // User Entered a valid mail
                                  else {
                                    return null;
                                  }
                                },
                                style: theme.textTheme.bodyText1.copyWith(
                                    fontFamily: "Product Sans",
                                    fontWeight: FontWeight.w600),
                                textInputAction: TextInputAction.next,
                                focusNode: _usernameNode,
                                cursorColor: theme.primaryColor,
                                controller: _usernameController,
                                onFieldSubmitted: (_) {
                                  _usernameNode.unfocus();
                                  FocusScope.of(context)
                                      .requestFocus(_passwordNode);
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 0),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.2),
                                      borderRadius: BorderRadius.circular(30)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.2),
                                      borderRadius: BorderRadius.circular(30)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black26),
                                      borderRadius: BorderRadius.circular(30)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                          width: 1.2),
                                      borderRadius: BorderRadius.circular(30)),
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.person_outline,
                                  ),
                                  labelStyle: theme.textTheme.bodyText1
                                      .copyWith(color: Colors.grey),
                                  labelText: 'رقم الهاتف / البريد الالكتروني',
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                textInputAction: TextInputAction.done,
                                autocorrect: true,
                                focusNode: _passwordNode,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'ادخل كلمة المرور';
                                  }
                                  if (value.length > 18 || value.length < 8)
                                    return "تاكد من ادخالك كلمة المرور بشكل صحيح";
                                  return null;
                                },
                                obscureText: true,
                                controller: _passwordController,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(18)
                                ],
                                decoration: InputDecoration(
                                  filled: true,
                                  errorMaxLines: 1,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.2),
                                      borderRadius: BorderRadius.circular(30)),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 0),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1.2),
                                      borderRadius: BorderRadius.circular(30)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                          width: 1.2),
                                      borderRadius: BorderRadius.circular(30)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black26),
                                      borderRadius: BorderRadius.circular(30)),
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                  ),
                                  labelStyle: theme.textTheme.bodyText1
                                      .copyWith(color: Colors.grey),
                                  labelText: 'كلمة المرور',
                                ),
                              ),
                              SizedBox(height: 10),
                              Builder(
                                builder: (context) => _loading
                                    ? Padding(
                                        child: SpinKitCircle(
                                            color: theme.primaryColor,
                                            size: 30),
                                        padding: EdgeInsets.only(top: 15),
                                      )
                                    : Container(
                                        width: double.infinity,
                                        child: RaisedButton(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 7),
                                          child: Text(
                                            'تسجيل دخول',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          textColor: theme.hintColor,
                                          elevation: 1,
                                          shape: StadiumBorder(),
                                          color: theme.primaryColor,
                                          highlightElevation: 0.1,
                                          onPressed: () async {
                                            String msg =
                                                await submitform(firebaseToken);

                                            Scaffold.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  msg,
                                                  style: theme
                                                      .textTheme.bodyText2
                                                      .copyWith(
                                                          color: Colors.white),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                              ),
                              SizedBox(height: 10),
                              Divider(
                                height: 2,
                                indent: 10,
                                endIndent: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () => Navigator.of(context)
                                            .pushNamed('/register'),
                                        child: Text(
                                          'ليس لديك حساب؟',
                                          style: TextStyle(
                                              color: theme.primaryColor),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushNamed(ForgetPass.routeName);
                                        },
                                        child: Text('لا تستطيع الوصول لحسابك؟',
                                            style: TextStyle(
                                              color: theme.primaryColor,
                                            )),
                                      )
                                    ]),
                              ),
                            ],
                          )),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

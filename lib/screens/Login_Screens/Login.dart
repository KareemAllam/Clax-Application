// Dart & Other Packages
// import 'package:http/http.dart';
// import 'package:provider/provider.dart';
// import 'package:toast/toast.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Utils
// import 'package:clax/services/Backend.dart';
// Providers
// import 'package:clax/Providers/Auth.dart';
// Screens
// import 'package:clax/screens/Login_Screens/ForgotPassword.dart';
// Widgets
// import 'package:clax/widgets/ExtendedAppBar.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
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
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameNode.dispose();
    _passwordNode.dispose();
  }

  Future<bool> submitform() async {
    if (_formKey.currentState.validate()) {
      Navigator.of(context).pushReplacementNamed('/screen');
      return true;
      // Authenticate From Server
      // Map<String, String> body = {
      //   "user": _usernameController.text.trim(),
      //   "pass": _passwordController.text
      // };
      // Response response = await Api.post('signing/passengers/login', body);
      // if (response.statusCode == 200) {
      //     # Update Cache with id
      //     Provider.of<Auth>(context, listen: false).logIn(response.body);
      //     Navigator.of(context).pushReplacementNamed('/screen');
      //     return true;
      // } else
      //   return false;
    } else
      return false;
  }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GestureDetector(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .copyWith(
                                      height: 1.4,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                              text: "\nفي كلاكس",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .copyWith(
                                      height: 1.4,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                              text: ".",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .copyWith(
                                      height: 1.4,
                                      color: Theme.of(context).primaryColor,
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
                                FocusScope.of(context)
                                    .requestFocus(_passwordNode);
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
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                fillColor: Colors.white,
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                ),
                                labelText: 'كلمة المرور',
                              ),
                            ),
                            SizedBox(height: 10),
                            Builder(
                              builder: (context) => Container(
                                width: double.infinity,
                                child: RaisedButton(
                                  padding: EdgeInsets.symmetric(vertical: 7),
                                  child: Text(
                                    'تسجيل دخول',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  textColor: Theme.of(context).hintColor,
                                  elevation: 1,
                                  shape: StadiumBorder(),
                                  color: Theme.of(context).primaryColor,
                                  highlightElevation: 0.1,
                                  onPressed: () async {
                                    bool result = await submitform();
                                    if (result == false)
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                          content: Text(
                                              "تأكد من اتصالك بالإنترنت و حاول مره اخرى.",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .copyWith(
                                                      color: Colors.white))));
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
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => Navigator.of(context)
                                          .pushNamed('/resetPassword'),
                                      child: Text('يوجد لديك مشكله؟',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
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
    );
  }
}

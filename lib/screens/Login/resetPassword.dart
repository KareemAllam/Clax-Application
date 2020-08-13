// Flutter's Material Components
import 'package:clax/screens/ClaxRoot.dart';
import 'package:clax/services/Backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Screens
// import 'package:clax/screens/Login_Screens/Login.dart';

class ResetPass extends StatefulWidget {
  static const routeName = 'resetPass';
  @override
  _ResetPassState createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  // --- Scaffold Key ---
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // --- Text FocusNodes & Controllers ---
  TextEditingController _password = TextEditingController();
  FocusNode _passwordNode = FocusNode();
  TextEditingController _confirmPassword = TextEditingController();
  FocusNode _confirmPasswordNode = FocusNode();
  // --- Password Visibilty & Checking ---
  String password;
  bool _hiddenPassword = true;

  @override
  void dispose() {
    super.dispose();
    _password.dispose();
    _passwordNode.dispose();
    _confirmPassword.dispose();
    _confirmPasswordNode.dispose();
  }

  void changePassword() async {
    if (_formKey.currentState.validate()) {
      Response response = await Api.put("signing/passengers/set-new-password",
          reqBody: {'pass': password});

      if (response.statusCode == 200) {
        // Save token
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        _prefs.setString("loginToken", response.headers['x-login-token']);
        // Navigate to App
        // Going Back to Login Screen
        Navigator.of(context).pop();
        // Navigating to Clax HomePage
        Navigator.of(context).pushReplacementNamed(ClaxRoot.routeName);
      }
      // If Temp token expired
      else if (response.statusCode == 401) {
        // Dismissing Current Screen
        Navigator.of(context).pop();
        // Show Expiration Messaage
      } else
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "تعذر الوصول للخادم. \n تأكد من اتصالك بالانترنت و حاول مره اخرى ",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(color: Colors.white),
            ),
          ),
        );
    } else
      return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.0,
          title: Text('اعداد كلمة المرور جديدة',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white)),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          child: Padding(
              padding: EdgeInsets.only(top: 16),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      // Password
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: TextFormField(
                          onEditingComplete: () {
                            _passwordNode.unfocus();
                            FocusScope.of(context)
                                .requestFocus(_confirmPasswordNode);
                          },
                          keyboardType: TextInputType.emailAddress,
                          controller: _password,
                          focusNode: _passwordNode,
                          scrollPadding: EdgeInsets.all(0),
                          inputFormatters: [
                            BlacklistingTextInputFormatter(RegExp('[\\-|\\ ]')),
                            LengthLimitingTextInputFormatter(16)
                          ],
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'ادخل كلمة المرور';
                            }
                            if (value.length > 18 || value.length < 8)
                              return "تاكد من ادخالك كلمة المرور بشكل صحيح";
                            password = value;
                            return null;
                          },
                          obscureText: _hiddenPassword,
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 0),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(30)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(30)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black26),
                                borderRadius: BorderRadius.circular(30)),
                            prefixIcon: Icon(
                              Icons.lock,
                            ),
                            suffixIcon: IconButton(
                                icon: Icon(
                                    _hiddenPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.black26),
                                onPressed: () => setState(() {
                                      _hiddenPassword = !_hiddenPassword;
                                    })),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: Theme.of(context).primaryColor),
                            ),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.grey),
                            labelText: 'كلمة المرور',
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      // Password
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: TextFormField(
                          onEditingComplete: () {
                            _confirmPasswordNode.unfocus();
                          },
                          keyboardType: TextInputType.emailAddress,
                          controller: _confirmPassword,
                          onFieldSubmitted: (_) => changePassword,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'ادخل كلمة المرور';
                            }
                            if (value.length > 18 || value.length < 8)
                              return "تاكد من ادخالك كلمة المرور بشكل صحيح";
                            if (value != password)
                              return "كلمة المرور غير متطابقة";
                            return null;
                          },
                          focusNode: _confirmPasswordNode,
                          scrollPadding: EdgeInsets.all(0),
                          inputFormatters: [
                            BlacklistingTextInputFormatter(RegExp('[\\-|\\ ]')),
                            LengthLimitingTextInputFormatter(16)
                          ],
                          cursorColor: Theme.of(context).primaryColor,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 0),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black26),
                                borderRadius: BorderRadius.circular(30)),
                            prefixIcon: Icon(
                              Icons.lock,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(30)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(30)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: Theme.of(context).primaryColor)),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.grey),
                            labelText: 'تأكيد كلمة المرور',
                          ),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: changePassword,
                        child: Container(
                            padding: EdgeInsets.all(16),
                            alignment: Alignment.center,
                            width: double.infinity,
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              "تغير كلمة المرور",
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                            )),
                      )
                    ],
                  ))),
        ));
  }
}

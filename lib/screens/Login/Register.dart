// Dart & Other Packages
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Providers
import 'package:clax/providers/Auth.dart';
// Static Data
import 'package:clax/governments.dart';
// Screens
import 'package:clax/screens/Login/Register2.dart';

class RegisterForm extends StatefulWidget {
  static const routeName = '/register';
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  Color governColor = Colors.black26;
  final RegExp phone = RegExp(r'^[0-9]+$');
  final RegExp phoneEgypt = RegExp(r'^01[0125][0-9]{8}$');
  bool _nameFocused = false;
  bool _nameError = false;
  bool _hiddenPassword = true;
  bool _loading = false;
  List<String> goverments = staticGoverments;
  String selectedGovernment;
  String password;
  TextEditingController _firstName = TextEditingController();
  FocusNode _firstNameNode = FocusNode();
  TextEditingController _lastName = TextEditingController();
  FocusNode _lastNameNode = FocusNode();
  TextEditingController _phone = TextEditingController();
  FocusNode _phoneNode = FocusNode();
  TextEditingController _password = TextEditingController();
  FocusNode _passwordNode = FocusNode();
  TextEditingController _confirmPassword = TextEditingController();
  FocusNode _confirmPasswordNode = FocusNode();

  Future<dynamic> register(firebaseToken) async {
    // Check For Validation Conditions
    _formKey.currentState.validate();
    bool result = _formKey.currentState.validate();

    if (selectedGovernment == null)
      governColor = Colors.red;
    else
      governColor = Colors.black26;
    // If Conditions aren't met or EULA isn't checks
    if (!result) {
      return;
    }
    // Input Data passed the required Conditions
    else {
      // Remove EULA not Checked Error
      Map<String, dynamic> body = {
        'name': {
          'first': _firstName.text,
          'last': _lastName.text,
        },
        'phone': _phone.text,
        'pass': _password.text,
        'fireBaseId': firebaseToken,
        'govern': selectedGovernment
      };

      Navigator.of(context)
          .pushNamed(RegisterForm2.routeName, arguments: {"data": body});

      // // Register The User from on Server
      // Response result = await Api.post("signing/passengers/register", body);
      // // If User's info is correct
      // if (result.statusCode == 200) {
      //   Provider.of<AuthProvider>(context, listen: false)
      //       .logIn(result.headers['x-login-token']);
      //   Navigator.pop(context);
      //   Navigator.pushReplacementNamed(context, '/homescreen');
      //   // Enable Register Button
      //   setState(() {
      //     _loading = true;
      //   });
      //   return 0;
      // }

      // // If User's info is incorrect
      // else if (result.statusCode == 409) {
      //   // Enable Register Button
      //   setState(() {
      //     _loading = false;
      //   });
      //   return result.body;
      // }

      // // If There is no Internet Connection
      // else {
      //   // Enable Register Button
      //   setState(() {
      //     _loading = false;
      //   });
      //   return 2;
      // }

    }
  }

  @override
  void dispose() {
    _firstName.dispose();
    _firstNameNode.dispose();
    _lastName.dispose();
    _lastNameNode.dispose();
    _phone.dispose();
    _phoneNode.dispose();
    _password.dispose();
    _passwordNode.dispose();
    _confirmPasswordNode.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    // الشروط والقوانين
    ThemeData theme = Theme.of(context);
    Color purple = theme.primaryColor;
    TextTheme textTheme = theme.textTheme;
    final String firebaseToken =
        Provider.of<AuthProvider>(context, listen: false).fbToken;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('حساب جديد',
            style: textTheme.bodyText1.copyWith(color: Colors.white)),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          setState(() {
            _nameFocused = false;
          });
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          physics:
              AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                  'assets/images/register.png',
                  colorBlendMode: BlendMode.overlay,
                  // color: purple,
                ),
                // Name
                Stack(
                  children: <Widget>[
                    Container(
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // First Name
                          Expanded(
                            child: TextFormField(
                              onEditingComplete: () {
                                _firstNameNode.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_lastNameNode);
                              },
                              onChanged: (value) {
                                if (value.endsWith(" ")) {
                                  _firstNameNode.unfocus();
                                  FocusScope.of(context)
                                      .requestFocus(_lastNameNode);
                                }
                              },
                              focusNode: _firstNameNode,
                              keyboardType: TextInputType.text,
                              controller: _firstName,
                              scrollPadding: EdgeInsets.all(0),
                              inputFormatters: [
                                WhitelistingTextInputFormatter(
                                    RegExp('[أ-ي \\-أ-ي]+\$')),
                                LengthLimitingTextInputFormatter(10)
                              ],
                              validator: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    _nameError = true;
                                  });
                                  return 'رجاءً، ادخل اسمك الاول.';
                                }
                                setState(() {
                                  _nameError = false;
                                });
                                return null;
                                // if(value.)
                              },
                              cursorColor: purple,
                              onTap: () => setState(() {
                                _nameFocused = true;
                              }),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 0),
                                prefixIcon: Icon(Icons.account_circle),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                labelStyle: theme.textTheme.bodyText1
                                    .copyWith(color: Colors.grey),
                                labelText: 'الأسم الأول',
                              ),
                            ),
                          ),

                          SizedBox(height: 10),

                          //Last Name
                          Expanded(
                            child: TextFormField(
                              onEditingComplete: () {
                                _lastNameNode.unfocus();
                                FocusScope.of(context).requestFocus(_phoneNode);
                              },
                              keyboardType: TextInputType.text,
                              controller: _lastName,
                              focusNode: _lastNameNode,
                              inputFormatters: [
                                WhitelistingTextInputFormatter(
                                    RegExp('[أ-ي\\-أ-ي]+\$')),
                                LengthLimitingTextInputFormatter(10)
                              ],
                              cursorColor: purple,
                              onTap: () => setState(() {
                                _nameFocused = true;
                              }),
                              validator: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    _nameError = true;
                                  });
                                  return 'رجاءً، ادخل اسمك الاخير.';
                                }
                                if (value.length < 3) {
                                  setState(() {
                                    _nameError = true;
                                  });
                                  return 'ادخل اسمك بشكل صحيح';
                                }

                                setState(() {
                                  _nameError = false;
                                });
                                return null;
                                // if(value.)
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 0),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                labelStyle: theme.textTheme.bodyText1
                                    .copyWith(color: Colors.grey),
                                labelText: 'الأسم الأخير',
                              ),
                            ),
                          ),
                        ]),
                    Container(
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: _nameError
                                      ? Colors.red
                                      : _nameFocused
                                          ? purple
                                          : Colors.black26)),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Phone
                TextFormField(
                  onEditingComplete: () {
                    _phoneNode.unfocus();
                  },
                  keyboardType: TextInputType.phone,
                  controller: _phone,
                  focusNode: _phoneNode,
                  scrollPadding: EdgeInsets.all(0),
                  inputFormatters: [
                    BlacklistingTextInputFormatter(RegExp('[\\-|\\ ]')),
                    WhitelistingTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11)
                  ],
                  validator: (value) {
                    if (phone.hasMatch(value)) {
                      // Wrong number of numbers.
                      if (value.length != 11)
                        return 'تأكد من ادخال رقمك بشكل صحيح.';
                      // Everything is good
                      if (phoneEgypt.hasMatch(value)) return null;
                      // Wrong Phone Number Format
                      return 'هذه الشركه غير مسجلة لدينا.';
                    }
                    return 'تأكد من ادخال رقمك بشكل صحيح.';
                  },
                  onTap: () => setState(() {
                    _nameFocused = false;
                  }),
                  cursorColor: purple,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(width: 1, color: Colors.red)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26),
                        borderRadius: BorderRadius.circular(30)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.red)),
                    prefixIcon: Icon(
                      Icons.phone,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(width: 1.5, color: purple)),
                    labelStyle:
                        theme.textTheme.bodyText1.copyWith(color: Colors.grey),
                    labelText: 'رقم الهاتف',
                  ),
                ),
                SizedBox(height: 10),
                // Password
                TextFormField(
                  onEditingComplete: () {
                    _passwordNode.unfocus();
                    FocusScope.of(context).requestFocus(_confirmPasswordNode);
                  },
                  keyboardType: TextInputType.emailAddress,
                  controller: _password,
                  focusNode: _passwordNode,
                  scrollPadding: EdgeInsets.all(0),
                  onTap: () => setState(() {
                    _nameFocused = false;
                  }),
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
                  cursorColor: purple,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.red)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(width: 1, color: Colors.red)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 0),
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
                        borderSide: BorderSide(width: 1.5, color: purple)),
                    labelStyle:
                        theme.textTheme.bodyText1.copyWith(color: Colors.grey),
                    labelText: 'كلمة المرور',
                  ),
                ),
                SizedBox(height: 10),
                // Password
                TextFormField(
                  onEditingComplete: () {
                    _confirmPasswordNode.unfocus();
                  },
                  keyboardType: TextInputType.emailAddress,
                  controller: _confirmPassword,
                  onTap: () => setState(() {
                    _nameFocused = false;
                  }),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'ادخل كلمة المرور';
                    }
                    if (value.length > 18 || value.length < 8)
                      return "تاكد من ادخالك كلمة المرور بشكل صحيح";
                    if (value != password)
                      return "تأكد من ادخالك نفس كلمة المرور";
                    return null;
                  },
                  focusNode: _confirmPasswordNode,
                  scrollPadding: EdgeInsets.all(0),
                  inputFormatters: [
                    BlacklistingTextInputFormatter(RegExp('[\\-|\\ ]')),
                    LengthLimitingTextInputFormatter(16)
                  ],
                  cursorColor: purple,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(width: 1, color: Colors.red)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26),
                        borderRadius: BorderRadius.circular(30)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.red)),
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(width: 1.5, color: purple)),
                    labelStyle:
                        theme.textTheme.bodyText1.copyWith(color: Colors.grey),
                    labelText: 'تأكيد كلمة المرور',
                  ),
                ),
                SizedBox(height: 10),
                // Government
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: governColor)),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: DropdownButton(
                    underline: SizedBox(),
                    hint: Row(
                      children: <Widget>[
                        Icon(Icons.location_city, color: Colors.grey),
                        SizedBox(width: 8),
                        Text("اختار محافظتك",
                            style: TextStyle(color: Colors.grey))
                      ],
                    ),
                    value: selectedGovernment,
                    items: goverments
                        .map((element) => DropdownMenuItem(
                            value: element,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.location_city, color: Colors.grey),
                                SizedBox(width: 8),
                                Text(element)
                              ],
                            )))
                        .toList(),
                    onChanged: (_) => setState(() => selectedGovernment = _),
                    isExpanded: true,
                  ),
                ),
                SizedBox(height: 8),
                // Register Button
                Builder(
                  builder: (context) => Container(
                    width: double.infinity,
                    child: _loading
                        ? Padding(
                            child: SpinKitCircle(color: purple, size: 30),
                            padding: EdgeInsets.only(top: 15),
                          )
                        : RaisedButton(
                            elevation: 0,
                            highlightElevation: 0,
                            onPressed: () => register(firebaseToken),
                            shape: StadiumBorder(),
                            color: purple,
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 5),
                            child: Text(
                              "التالي",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

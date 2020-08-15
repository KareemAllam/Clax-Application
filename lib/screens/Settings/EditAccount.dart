// Dart & Other Packages
import 'package:clax/models/Error.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Providers
import 'package:clax/providers/Profile.dart';
// Utils
import 'package:clax/utils/password.dart';
// Models
import 'package:clax/models/Name.dart';
import 'package:clax/models/Profile.dart';
// Screens
import 'package:clax/screens/Login/Verification.dart';

class Account extends StatefulWidget {
  static const routeName = '/Account';
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final _form = GlobalKey<FormState>();
  bool loading = false;
  ProfileModel _originalProfile;
  String pass = '';
  String email = '';
  String phone = '';
  NameModel name = NameModel(first: '', last: '');
  bool error = false;
  String confirmPass;
  TextEditingController passwordController = TextEditingController();

  Future<ServerResponse> _saveForm() async {
    setState(() {
      loading = true;
    });
    final isValid = _form.currentState.validate();
    setState(() {
      loading = false;
    });
    if (!isValid)
      return ServerResponse(
          status: false, message: 'تاكد من ادخال البيانات بشكل صحيح');

    Map<String, dynamic> finalData = {};
    _form.currentState.save();

    if (name.first != '' || name.last != '') {
      finalData['firstName'] =
          name.first == "" ? _originalProfile.name.first : name.first;

      finalData['lastName'] =
          name.last == "" ? _originalProfile.name.last : name.last;
    }

    if (phone != '') {
      finalData['phone'] = phone == '' ? _originalProfile.phone : phone;
    }
    if (email != '')
      finalData['mail'] = email == '' ? _originalProfile.mail : email;

    if (!pass.contains("*")) {
      if (verifyPassword(pass, _originalProfile.passHashed)) {
        finalData['pass'] = pass;
        finalData['passLength'] = pass.length.toString();
      }
    }

    if (finalData.isNotEmpty) {
      ServerResponse result =
          await Provider.of<ProfilesProvider>(context, listen: false)
              .updateProfile(finalData);
      setState(() {
        loading = false;
      });
      if (result.status) Navigator.pop(context);
      return result;
    }
    setState(() {
      loading = false;
    });
    Navigator.pop(context);
    return ServerResponse(status: true);
  }

  void initState() {
    super.initState();
    _originalProfile =
        Provider.of<ProfilesProvider>(context, listen: false).profile;
    passwordController.text = password(_originalProfile.passLength);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          ' تعديل حسابك',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white),
        ),
        actions: <Widget>[
          Builder(builder: (BuildContext context) {
            return IconButton(
                icon: loading
                    ? SpinKitThreeBounce(color: Colors.white, size: 15)
                    : Icon(Icons.save),
                onPressed: loading
                    ? () {}
                    : () async {
                        await _saveForm();
                        // ServerResponse result = await _saveForm();
                        // // Internet Connection
                        // if (!result.status)
                        //   Scaffold.of(context).showSnackBar(
                        //     SnackBar(
                        //       backgroundColor: Colors.red,
                        //       content: Text(
                        //         result.message,
                        //         //  "لقد تعذر الوصول للخادم. حاول مره اخرى في وقت لاحق"
                        //         style: Theme.of(context)
                        //             .textTheme
                        //             .bodyText2
                        //             .copyWith(color: Colors.white),
                        //         strutStyle: StrutStyle(forceStrutHeight: true),
                        //       ),
                        //     ),
                        //   );
                        // Phone Data Changed
                        // else
                        if (phone != '')
                          Navigator.of(context)
                              .pushReplacementNamed(Verification.routeName);
                      });
          })
        ],
      ),
      body: Form(
        key: _form,
        child: ListView(
          children: <Widget>[
            Image.asset(
              'assets/images/abcd.jpg',
            ),
            TextFormField(
              initialValue: _originalProfile.name.first +
                  " " +
                  _originalProfile.name.last,
              inputFormatters: [
                WhitelistingTextInputFormatter(RegExp(
                    "^([A-Z][a-z]+([ ]?[a-z]?['-]?[A-Z][a-z]+)*)\$|^([ء-ي]+([ ]?[ء-ي]))*\$")),
                LengthLimitingTextInputFormatter(10)
              ],
              decoration: InputDecoration(
                  labelText: 'الأسم:',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.person)),
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value.isEmpty) {
                  return 'ادخل اسمك';
                }
                return null;
              },
              onSaved: (value) {
                name.first = '';
                name.last = '';
                value = value.trimLeft();
                value = value.trimRight();
                if (value !=
                    '${_originalProfile.name.first} ${_originalProfile.name.last}') {
                  List<String> _name = value.split(' ');
                  name.first = _name[0];
                  name.last = _name[1];
                }
              },
            ),
            TextFormField(
                initialValue: _originalProfile.phone,
                decoration: InputDecoration(
                    labelText: 'رقم الهاتف',
                    filled: true,
                    counterText: "",
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.phone)),
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  BlacklistingTextInputFormatter(RegExp('[\\-|\\ ]')),
                  WhitelistingTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11)
                ],
                maxLength: 11,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  RegExp phone = RegExp(r'^[0-9]+$');
                  if (phone.hasMatch(value)) {
                    // Wrong number of numbers.
                    if (value.length != 11)
                      return 'تأكد من ادخال رقمك بشكل صحيح.';
                    // Everything is good
                    RegExp phoneEgypt = RegExp(r'^01[0125][0-9]{8}$');
                    if (phoneEgypt.hasMatch(value)) return null;
                    // Wrong Phone Number Format
                    return 'هذه الشركه غير مسجلة لدينا.';
                  }
                  return 'تأكد من ادخال رقمك بشكل صحيح.';
                },
                onSaved: (value) {
                  phone = '';
                  if (value != _originalProfile.phone) phone = value;
                }),
            TextFormField(
                initialValue: _originalProfile.mail,
                cursorColor: Theme.of(context).primaryColor,
                inputFormatters: [
                  BlacklistingTextInputFormatter(RegExp('[\\-|\\ ]')),
                ],
                decoration: InputDecoration(
                    labelText: 'البريد الالكتروني',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.email)),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == "") {
                    return "من فضلك، ادخالك البريد الالكتروني";
                  }
                  RegExp email = RegExp(
                      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");
                  if (!email.hasMatch(value)) {
                    return "تأكد من ادخال البريد الالكتروني بشكل صحيح";
                  }
                  // User Entered a valid mail
                  else {
                    return null;
                  }
                },
                onSaved: (value) {
                  email = '';
                  if (_originalProfile.mail != value) email = value;
                }),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  labelText: 'كلمة السر',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.lock)),
              textInputAction: TextInputAction.done,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value.isEmpty) {
                  return 'من فضلك، قم بإدخال كلمة المرور ';
                }
                if (value.length < 8) {
                  return 'كلمة المرور ضعيفة';
                }
                RegExp regExp = new RegExp(
                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                if (regExp.hasMatch(value))
                  return "كلمة المرور يجب ان تحتوى علي احرف كبيرةو صغيرة و ارقام";
                return null;
              },
              onSaved: (value) {
                pass = value;
              },
            ),
            TextFormField(
              initialValue: password(_originalProfile.passLength),
              decoration: InputDecoration(
                  labelText: 'تأكيد كلمة السر',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.lock)),
              textInputAction: TextInputAction.done,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value.isEmpty) {
                  return 'من فضلك، قم بإدخال كلمة المرور ';
                }
                if (value != passwordController.text) {
                  return 'كلمة المرور غير متاطبقة';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}

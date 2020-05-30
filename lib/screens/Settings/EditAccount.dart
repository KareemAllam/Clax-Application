// Dart & Other Packages
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Providers
import 'package:clax/providers/Profile.dart';
// Utils
import 'package:clax/utils/password.dart';
// Models
import 'package:clax/models/profile.dart';
// Screens
import 'package:clax/screens/Login/Verification.dart';

class Account extends StatefulWidget {
  static const routeName = '/Account';
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final _form = GlobalKey<FormState>();
  ProfileModel _originalProfile;
  String pass = '';
  String email = '';
  String phone = '';
  NameModel name = NameModel(first: '', last: '');
  bool error = false;
  String confirmPass;
  TextEditingController passwordController = TextEditingController();

  Future<String> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) return 'FormError';

    Map<String, dynamic> finalData = {};
    _form.currentState.save();

    if (name.first != '' || name.last != '') {
      finalData['firstName'] =
          name.first == "" ? _originalProfile.name.first : name.first;
      _originalProfile.name.first = finalData['firstName'];

      finalData['lastName'] =
          name.last == "" ? _originalProfile.name.last : name.last;
      _originalProfile.name.last = finalData['lastName'];
    }

    if (phone != '') {
      finalData['phone'] = phone == '' ? _originalProfile.phone : phone;
      _originalProfile.phone = phone;
    }
    if (email != '')
      finalData['mail'] = email == '' ? _originalProfile.mail : email;

    if (verifyPassword(pass, _originalProfile.passHashed)) {
      _originalProfile.passHashed = hashedPassword(pass);
      _originalProfile.passLength = pass.length;
      finalData['pass'] = pass;
      finalData['passLength'] = pass.length.toString();
    }

    if (finalData.isNotEmpty) {
      String result =
          await Provider.of<ProfilesProvider>(context, listen: false)
              .updateProfile(finalData, _originalProfile);
      return result;
    } else
      Navigator.pop(context);
    return "";
  }

  void initState() {
    super.initState();
    _originalProfile =
        Provider.of<ProfilesProvider>(context, listen: false).profile;
    passwordController.text = password(_originalProfile.passLength);
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
                icon: Icon(Icons.save),
                onPressed: () async {
                  String result = await _saveForm();
                  // Internet Connection
                  if (result == "error")
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "تأكد من اتصالك بالإنترنت و حاول مره اخرى.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Colors.white))));
                  // Phone Data Changed
                  else {
                    if (phone != '')
                      Navigator.of(context)
                          .pushReplacementNamed(Verification.routeName);
                  }
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
                  List<String> name = value.split(' ');
                  name.first = name[0];
                  name.last = name[1];
                }
              },
            ),
            TextFormField(
                initialValue: _originalProfile.phone,
                decoration: InputDecoration(
                    labelText: 'رقم الهاتف',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.phone)),
                textInputAction: TextInputAction.done,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'من فضلك، قم بإدخال رقم الهاتف';
                  }
                  if (value.length != 11) {
                    return 'قم بإدخال الرقم بشكل صحيح';
                  }
                  return null;
                },
                onSaved: (value) {
                  phone = '';
                  if (value != _originalProfile.phone) phone = value;
                }),
            TextFormField(
                initialValue: _originalProfile.mail,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                    labelText: 'البريد الالكتروني',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.email)),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'من فضلك، قم بإدخال البريد الإلكتروني';
                  }
                  return null;
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

import 'package:clax/models/profile.dart';
import 'package:clax/providers/profiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../screens/verification.dart';
import '../utils/password.dart';

class Account extends StatefulWidget {
  static const routeName = '/Account';
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final _form = GlobalKey<FormState>();
  Profile _originalProfile;
  String pass = '';
  String email = '';
  String phone = '';
  Name name = Name(first: '', last: '');
  bool error = false;

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

    if (verifyPassword(pass, _originalProfile.pass)) {
      _originalProfile.pass = hashedPassword(pass);
      _originalProfile.passLength = pass.length;
      finalData['pass'] = pass;
      finalData['passLength'] = pass.length.toString();
    }

    if (finalData.isNotEmpty) {
      String result = await Provider.of<Profiles>(context, listen: false)
          .updateProfile(finalData, _originalProfile);
      return result;
    } else
      Navigator.pop(context);
  }

  void initState() {
    super.initState();
    _originalProfile = Provider.of<Profiles>(context, listen: false).profile;
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
                    print(result);
                    // Internet Connection
                    if (result == "error")
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "تأكد من اتصالك بالإنترنت و حاول مره اخرى.",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(color: Colors.white))));
                    // Form Data Changed
                    else if (result == 'FormError')
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("تأكد من معلومات و حاول مره اخرى.",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(color: Colors.white))));
                    else {
                      if (phone != '')
                        Navigator.of(context).pushReplacementNamed(
                            EVerify.routeName,
                            arguments: {'route': "/yourAcc"});
                      // Nothing Changed
                      else
                        Navigator.of(context).pop();
                    }
                  });
            })
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                Image.asset(
                  'assets/images/avatar.jpg',
                ),
                TextFormField(
                  initialValue: _originalProfile.name.first ?? "",
                  decoration: InputDecoration(labelText: 'الأسم الأول'),
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value.isEmpty) {
                      return ' عفوًا، قم بإدخال الأسم الأول';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    name.first = '';
                    if (value != _originalProfile.name.first)
                      name.first = value;
                  },
                ),
                TextFormField(
                  initialValue: _originalProfile.name.last,
                  decoration: InputDecoration(labelText: 'الأسم الأخير'),
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'عفوًا، قم بإدخال الأسم الأخير';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    name.last = '';
                    if (value != _originalProfile.name.last) name.last = value;
                  },
                ),
                TextFormField(
                    initialValue: _originalProfile.phone,
                    decoration: InputDecoration(labelText: 'رقم الموبايل'),
                    textInputAction: TextInputAction.done,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
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
                        labelText: 'البريد الألكتروني',
                        fillColor: Colors.white),
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
                  initialValue: password(_originalProfile.passLength),
                  decoration: InputDecoration(
                      labelText: 'كلمة المرور',
                      hintText: password(_originalProfile.passLength)),
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
              ],
            ),
          ),
        ));
  }
}

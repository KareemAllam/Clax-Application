import "package:flutter/material.dart";

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  String namePlaceHolder;
  String emailPlaceHolder;
  String phonePlaceHolder;
  String passwordPlaceHolder;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            title: Text(
              'تسجيل الدخول',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white),
            )),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Spacer(flex: 1),
            Container(
              alignment: Alignment.center,
              child: Text("مربحا بك معنا",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black87,
                      fontWeight: FontWeight.w800)),
            ),
            Spacer(flex: 1),
            TextField(keyboardType: TextInputType.text, controller: name),
            Spacer(flex: 1),
            TextField(
                keyboardType: TextInputType.emailAddress, controller: email),
            Spacer(flex: 1),
            TextField(keyboardType: TextInputType.phone, controller: phone),
            Spacer(flex: 1),
            TextField(
              cursorColor: Theme.of(context).primaryColor,
              keyboardType: TextInputType.text,
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  helperText: "من فضلك ادخل الإيميل الخاص بك",
                  helperStyle: TextStyle()),
            ),
            Spacer(flex: 5),
          ],
        ));
  }
}

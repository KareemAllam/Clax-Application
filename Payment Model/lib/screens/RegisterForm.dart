// import 'dart:async';
// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String _emailPlaceholder = 'كلمة المرور';

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('سجل دخولك',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20, top: 20, bottom: 5),
                child: Text("البريد الالكتروني:")),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.only(right: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black38)),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: email,
                onChanged: (_) {},
                scrollPadding: EdgeInsets.all(0),
                inputFormatters: [
                  BlacklistingTextInputFormatter(RegExp('[\\-|\\ ]')),
                ],
                onSubmitted: (_) {},
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  icon: Icon(Icons.payment),
                  focusedBorder: InputBorder.none,
                  hintText: "eample@gmail.com",
                  hintStyle: TextStyle(
                      fontFamily: 'Product Sans',
                      fontSize: 14,
                      color: Colors.black38),
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text(_emailPlaceholder,
                  style: _emailPlaceholder.contains("فضلك")
                      ? Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Theme.of(context).primaryColor)
                      : Theme.of(context).textTheme.headline5),
            ),
            // ---------------------------------
            Padding(
                padding: EdgeInsets.only(right: 20, top: 5, bottom: 5),
                child: Text("رقم الهاتف:")),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.only(right: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black38)),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: email,
                onChanged: (_) {},
                scrollPadding: EdgeInsets.all(0),
                inputFormatters: [
                  BlacklistingTextInputFormatter(RegExp('[\\-|\\ ]')),
                  WhitelistingTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11)
                ],
                onSubmitted: (_) {},
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  icon: Icon(Icons.payment),
                  focusedBorder: InputBorder.none,
                  hintText: "010123456789",
                  hintStyle: TextStyle(
                      fontFamily: 'Product Sans',
                      fontSize: 14,
                      color: Colors.black38),
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text(_emailPlaceholder,
                  style: _emailPlaceholder.contains("فضلك")
                      ? Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Theme.of(context).primaryColor)
                      : Theme.of(context).textTheme.headline5),
            ),
            // ---------------------------------
            Padding(
                padding: EdgeInsets.only(right: 20, top: 5, bottom: 5),
                child: Text(":")),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.only(right: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black38)),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: email,
                onChanged: (_) {},
                scrollPadding: EdgeInsets.all(0),
                inputFormatters: [
                  BlacklistingTextInputFormatter(RegExp('[\\-|\\ ]')),
                  WhitelistingTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16)
                ],
                onSubmitted: (_) {},
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  icon: Icon(Icons.payment),
                  focusedBorder: InputBorder.none,
                  hintText: "eample@gmail.com",
                  hintStyle: TextStyle(
                      fontFamily: 'Product Sans',
                      fontSize: 14,
                      color: Colors.black38),
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text(_emailPlaceholder,
                  style: _emailPlaceholder.contains("فضلك")
                      ? Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Theme.of(context).primaryColor)
                      : Theme.of(context).textTheme.headline5),
            ),
            // ---------------------------------
            Padding(
                padding: EdgeInsets.only(right: 20, top: 5, bottom: 5),
                child: Text("البريد الالكتروني:")),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.only(right: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black38)),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: email,
                onChanged: (_) {},
                scrollPadding: EdgeInsets.all(0),
                inputFormatters: [
                  BlacklistingTextInputFormatter(RegExp('[\\-|\\ ]')),
                  WhitelistingTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16)
                ],
                onSubmitted: (_) {},
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  icon: Icon(Icons.payment),
                  focusedBorder: InputBorder.none,
                  hintText: "eample@gmail.com",
                  hintStyle: TextStyle(
                      fontFamily: 'Product Sans',
                      fontSize: 14,
                      color: Colors.black38),
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text(_emailPlaceholder,
                  style: _emailPlaceholder.contains("فضلك")
                      ? Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Theme.of(context).primaryColor)
                      : Theme.of(context).textTheme.headline5),
            ),
            // ---------------------------------
            Column(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {},
                  shape: StadiumBorder(),
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                  child: Text(
                    "تسجيل",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700),
                  ),
                ),
                // Row(
                //   children: <Widget>[
                //     Text("عندك مشكلة في التسجيل؟",
                //         style: TextStyle(color: Colors.grey, fontSize: 14)),
                //     Text(" اضغط هنا",
                //         style: TextStyle(
                //             color: Theme.of(context).primaryColor,
                //             fontSize: 14))
                //   ],
                // )
              ],
            )
          ],
        ),
      ),
    );
  }
}

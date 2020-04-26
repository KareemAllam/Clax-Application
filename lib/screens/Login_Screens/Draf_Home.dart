// Dart & Other Packages
import 'package:provider/provider.dart';
// Widgets
import 'package:flutter/material.dart';
// Poviders
import 'package:clax/Providers/Auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الصفحه الرئيسية")),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text("You are Autheroized"),
            RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 20),
                color: Theme.of(context).primaryColor,
                child: Text("تسجيل الخروج"),
                onPressed: () {
                  bool result =
                      Provider.of<Auth>(context, listen: false).logOut();
                  if (result)
                    Navigator.pushReplacementNamed(context, '/login');
                  else
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text("تعذر الخروج من حساب"),
                      ),
                    );
                })
          ],
        ),
      ),
    );
  }
}

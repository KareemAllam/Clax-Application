// Dart & Other Packages
import 'dart:convert';
// Flutter's Material Components
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Services
import 'package:clax/services/Backend.dart';
// Widgets
import 'package:clax/widgets/alertDialog.dart';
import 'package:clax/widgets/appBar.dart';
import 'package:clax/widgets/drawer.dart';

class FreeRides extends StatefulWidget {
  static const routeName = '/freeRides';

  @override
  _FreeRidesState createState() => _FreeRidesState();
}

class _FreeRidesState extends State<FreeRides> {
  TextEditingController promocode = TextEditingController();
  bool success = false;
  bool valid = false;

  void sendCode(BuildContext context) async {
    Map<String, dynamic> body = {
      'code': promocode.text,
    };

    await Api.post('offers', json.encode(body)).then(
      (response) {
        Map<String, dynamic> responseBody = json.decode(response.body);
        String code;
        String content;
        if (response.statusCode == 200) {
          code = 'success';
          content = responseBody["message"];
        } else if (response.statusCode == 404) {
          code = 'incorrect';
          content = "ds";
        } else {
          code = 'repeated';
          content = "ds";
        }

        showAlertDialog(context: context, code: code, content: content);
      },
    ).catchError((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'الرحلات المجانية'),
      drawer: MainDrawer(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).scaffoldBackgroundColor,
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "برومو كود جديد:",
                textAlign: TextAlign.right,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.black87),
              ),
              TextField(
                controller: promocode,
                textInputAction: TextInputAction.done,
                // keyboardType: TextInputType.number,
                onEditingComplete: () {
                  // if (promocode.text == '11')
                  //   setState(() {
                  //     success = true;
                  //     valid = true;
                  //   });
                  // else if (promocode.text == '22')
                  //   setState(() {
                  //     success = false;
                  //     valid = true;
                  //   });
                  // else
                  //   setState(() {
                  //     success = true;
                  //     valid = false;
                  //   });
                },
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]"))
                ],
                decoration: InputDecoration(
                  filled: true,
                  errorMaxLines: 1,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.card_giftcard,
                  ),
                  labelStyle: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.grey),
                  labelText: 'ادخل البروموكود',
                ),
              ),
              FlatButton(
                child: Text('يلا كلاكس'),
                textColor: Theme.of(context).primaryColor,
                onPressed: () async {
                  sendCode(context);
                },
              ),
              // SizedBox(height: 18),
              Text(
                "الكوبونات الحاليه:",
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.headline5.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

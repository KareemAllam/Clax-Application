import 'package:flutter/material.dart';
import 'package:loginreg/screens/loginScreen.dart';
import 'package:toast/toast.dart';

class resetPass extends StatefulWidget {
  @override
  _resetPassState createState() => _resetPassState();
}

class _resetPassState extends State<resetPass> {
  TextEditingController mailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('اعداد كلمة المرور جديدة'),

        ),
        body: Padding(
            padding: EdgeInsets.all(10),

            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(

                        autocorrect: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'أدخل الرمز';
                          }
                          return null;
                        },
                        controller: mailController,
                        decoration: InputDecoration(

                          labelText: 'أدخل الرمز',
                          icon: new Icon(
                            Icons.euro_symbol,
                            color: Color(0xffff9e50),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(

                        autocorrect: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'كلمة المرور الجديدة';
                          }
                          return null;
                        },
                        controller: mailController,
                        decoration: InputDecoration(

                          labelText: 'كلمة المرور الجديدة',
                          icon: new Icon(
                            Icons.lock,
                            color: Color(0xffff9e50),
                          ),
                        ),
                      ),
                    ),

                    Container(
                        height: 50,
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: RaisedButton(

                          child: Text('تأكيد',style: Theme.of(context).textTheme.title,),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              // If the form is valid
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Login()),
                              );
                              Toast.show(mailController.text, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                            }
                            print(mailController.text);




                          },
                        )),

                  ],)
            ))
    );
  }
}

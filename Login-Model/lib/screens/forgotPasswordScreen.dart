import 'package:flutter/material.dart';
import 'package:loginreg/screens/resetPassScreen.dart';
import 'package:toast/toast.dart';

class forgetPass extends StatefulWidget {
  @override
  _forgetPassState createState() => _forgetPassState();
}

class _forgetPassState extends State<forgetPass> {
  TextEditingController mailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(' كلمة المرور'),
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
                            return 'ادخل البريد الألكتروني';
                          }
                          return null;
                        },
                        controller: mailController,
                        decoration: InputDecoration(

                          labelText: 'البريد الألكتروني',
                          icon: new Icon(
                            Icons.mail,
                            color: Colors.grey,
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
                                MaterialPageRoute(builder: (context) => resetPass()),
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

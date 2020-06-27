import 'package:flutter/material.dart';
import 'package:loginreg/screens/forgotPasswordScreen.dart';
import 'package:toast/toast.dart';
import 'package:loginreg/utils/loginMethod.dart';
class Login extends StatefulWidget {
  @override
  Login_State createState() => Login_State();
}

class Login_State extends State<Login> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('تسجيل الدخول'),
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
        return 'ادخل اسم المستخدم';
        }
        return null;
        },
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                        icon: new Icon(
                          Icons.person_outline,
                          color: Colors.grey,
                        ),
                      labelText: 'اسم المستخدم',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                  autocorrect: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'ادخل كلمة المرور';
                    }
                    return null;
                  },
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                        icon: new Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                      labelText: 'كلمة المرور',
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: (){
                    //forgot password screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => forgetPass()),
                    );                  },
                  textColor: Theme.of(context).hintColor,
                  child: Text(' نسيت كلمة المرور'),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(

                      child: Text('تسجيل دخول',style: Theme.of(context).textTheme.title,),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          // If the form is valid
                          Toast.show(nameController.text, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
                        }
                        print(nameController.text);
                        print(passwordController.text);



                      },
                    )),
                Container(
                    child: Row(
                      children: <Widget>[
                        Text('ليس لديك حساب؟', style: TextStyle(color: Theme.of(context).hintColor),),
                        FlatButton(
                          textColor:  Theme.of(context).hintColor,
                          child: Text(
                            'تسجيل جديد',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            //signup screen
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
              ],)
            )));
  }
}
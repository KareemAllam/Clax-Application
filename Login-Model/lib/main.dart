import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loginreg/screens/loginScreen.dart';

import 'package:loginreg/screens/login_Screen.dart';

void main() => {runApp(MyApp()),

};


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return

//          providers: [
//            ChangeNotifierProvider.value(
//              value: AppState(),
//            ),
//          ],

          MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('ar', 'AE')
              // OR Locale('ar', 'AE') OR Other RTL locales
            ],

            title: 'Clax',
            theme: ThemeData(
                primaryColor: Color(0xff3c23ad) ,
                accentColor:Color(0xff80808),
                backgroundColor:Colors.white,
                hintColor: Color(0xff3c23ad),
                buttonTheme: ThemeData.light().buttonTheme.copyWith(buttonColor: Color(0xff3c23ad)),
                textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                      color: Color(0xffffffff),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Cairo'
                    )),
                appBarTheme: AppBarTheme(
                  textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 20,
                      color: Color(0xffffffff),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
            initialRoute: 'Login',
            routes: {
              'Login': (context) => Login(),
              //'log2':(context)=>LoginScreen()


            },
            );

  }
}

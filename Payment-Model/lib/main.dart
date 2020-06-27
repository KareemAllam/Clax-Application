import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_complete_guide/Provider/Account.dart';
import 'package:flutter_complete_guide/Provider/Complains.dart';
import 'package:flutter_complete_guide/Provider/Payments.dart';
import 'package:flutter_complete_guide/Provider/Trips.dart';
import 'package:flutter_complete_guide/Provider/Transactions.dart';
import 'package:flutter_complete_guide/screens/SplashScreen.dart';
import 'package:provider/provider.dart';
import './configuration.dart' as application;
import './screens/Complaint_Details.dart';
import './screens/complains_Historty.dart';
import './screens/Payment_Add.dart';
import './screens/Payment_HomeScreen.dart';
import './screens/Complains_Screen.dart';
import './screens/Test.dart';
import './screens/RegisterForm.dart';
import './screens/Complain_Write.dart';
import './screens/Payment_History.dart';
import './screens/Payment_TransferMoney.dart';
import './webview.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(create: (context) => Account()),
          Provider(create: (context) => Complains()),
          Provider(create: (context) => Trips()),
          Provider(create: (context) => Transactions()),
          Provider(create: (context) => Payments()),
          ChangeNotifierProvider(create: (context) => Account()),
          ChangeNotifierProvider(create: (context) => Complains()),
          ChangeNotifierProvider(create: (context) => Trips()),
          ChangeNotifierProvider(create: (context) => Transactions()),
          ChangeNotifierProvider(create: (context) => Payments())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: application.localization,
          supportedLocales: application.languages,
          locale: application.local,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: Color(0xffe3e8ee),
            dividerColor: Colors.black12,
            primaryColor: Colors.deepPurple,
            accentColor: Colors.amber,
            backgroundColor: Colors.white,
            secondaryHeaderColor: Colors.grey,
            canvasColor: Colors.white,
            fontFamily: 'Cairo',
            textTheme: TextTheme(
              headline1: TextStyle(
                fontSize: 102,
                letterSpacing: -1.5,
                fontWeight: FontWeight.w200,
              ),
              headline2: TextStyle(
                  fontSize: 64,
                  letterSpacing: -0.5,
                  fontWeight: FontWeight.w200),
              headline3: TextStyle(
                  fontSize: 51, letterSpacing: 0, fontWeight: FontWeight.w400),
              headline4: TextStyle(
                  fontSize: 36,
                  letterSpacing: 0.25,
                  fontWeight: FontWeight.w400),
              headline5: TextStyle(
                  fontSize: 25, letterSpacing: 0, fontWeight: FontWeight.w400),
              headline6: TextStyle(
                  fontSize: 21,
                  letterSpacing: 0.15,
                  fontWeight: FontWeight.w600),
              subtitle1: TextStyle(
                  fontSize: 17,
                  letterSpacing: 0.15,
                  fontWeight: FontWeight.w400),
              subtitle2: TextStyle(
                  fontSize: 15,
                  letterSpacing: 0.1,
                  fontWeight: FontWeight.w600),
              bodyText1: TextStyle(
                  fontSize: 17,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w400),
              bodyText2: TextStyle(
                  fontSize: 15,
                  letterSpacing: 0.25,
                  fontWeight: FontWeight.w400),
              button: TextStyle(
                  fontSize: 15,
                  letterSpacing: 1.25,
                  fontWeight: FontWeight.w600),
              caption: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.w400),
              overline: TextStyle(
                  fontSize: 11,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w400),
            ),
          ),
          title: 'Flutter Demo',
          home: SplashScreen(),
          routes: <String, WidgetBuilder>{
            '/Main': (BuildContext context) => MyHomePage(),
            '/Login': (BuildContext context) => RegisterForm(),
            '/payment': (BuildContext context) => PaymentScreen(),
            '/payment/transfer_money': (BuildContext context) =>
                TransferMoney(),
            '/payment/add': (BuildContext context) => PaymentAdd(),
            '/payment/payment_history': (BuildContext context) =>
                PaymentHistory(),
            '/payment/complaints': (BuildContext context) => new Complaints(),
            '/payment/complaints/writeAComplain': (BuildContext context) =>
                WriteAComplain(),
            '/payment/complaints/complaintsHistory': (BuildContext context) =>
                ComplaintsHistory(),
            '/payment/complaints/complaintsHistory/complaintDetails':
                (BuildContext context) => ComplainDetails(),
            '/payment/paypal': (BuildContext context) => Web(),
            '/Test': (BuildContext context) => Test(),
            '/splash': (BuildContext context) => SplashScreen(),
          },
        ));
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TestProject',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            textTheme: ButtonTextTheme.primary,
            child: Container(
              alignment: Alignment.center,
              child: Text('Go to Settings',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              width: double.infinity,
            ),
            onPressed: () => Navigator.of(context).pushNamed('/payment'),
          ),
          FlatButton(
            textTheme: ButtonTextTheme.primary,
            child: Container(
              alignment: Alignment.center,
              child: Text('Web View',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              width: double.infinity,
            ),
            onPressed: () => Navigator.of(context).pushNamed('/payment/paypal',
                arguments: {'url': "www.google.com"}),
          ),
          FlatButton(
            textTheme: ButtonTextTheme.primary,
            child: Container(
              alignment: Alignment.center,
              child: Text('Login',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              width: double.infinity,
            ),
            onPressed: () => Navigator.of(context).pushNamed('/Login'),
          ),
          FlatButton(
            textTheme: ButtonTextTheme.primary,
            child: Container(
              alignment: Alignment.center,
              child: Text('Test',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              width: double.infinity,
            ),
            onPressed: () => Navigator.of(context).pushNamed('/Test'),
          ),
          FlatButton(
            textTheme: ButtonTextTheme.primary,
            child: Container(
              alignment: Alignment.center,
              child: Text('Splash Screen',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              width: double.infinity,
            ),
            onPressed: () => Navigator.of(context).pushNamed('/splash'),
          ),
        ],
      ),
    );
  }
}

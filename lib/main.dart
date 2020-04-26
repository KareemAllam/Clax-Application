// Dart & Other Packages;
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// Providers
import 'package:clax/Providers/Auth.dart';
// Screens
import 'package:clax/screens/Home/Clax.dart';
import 'package:clax/screens/Login_Screens/Login.dart';
import 'package:clax/screens/Login_Screens/RegisterForm.dart';
import 'package:clax/screens/Login_Screens/LoadMainScreen.dart';
import 'package:clax/screens/Login_Screens/Verification.dart';
import 'package:clax/screens/Login_Screens/ForgotPassword.dart';
import 'package:clax/screens/Home/Account.dart';
import 'package:clax/screens/Home/Bookings.dart';
import 'package:clax/screens/Home/Components/Family.dart';
import 'package:clax/screens/Home/Components/family_members.dart';
import 'package:clax/screens/Home/Components/history.dart';
import 'package:clax/screens/Home/Components/new_trip.dart';
import 'package:clax/screens/Home/Free_Rides.dart';
import 'package:clax/screens/Home/Guide.dart';
import 'package:clax/screens/Home/Members.dart';
import 'package:clax/screens/Home/More.dart';
import 'package:clax/screens/Home/Notifications.dart';
import 'package:clax/screens/Home/Pay.dart';
import 'package:clax/screens/Home/Payments.dart';
import 'package:clax/screens/Home/Rahalatk.dart';
import 'package:clax/screens/Home/Safety.dart';
import 'package:clax/screens/Home/Signout.dart';
import 'package:clax/screens/Home/cancellations.dart';
import 'package:clax/screens/Home/creditCard.dart';
import 'package:clax/screens/Home/help.dart';
import 'package:clax/screens/Home/payOptions.dart';
import 'package:clax/screens/Home/promoCodes.dart';
import 'package:clax/screens/Home/settings.dart';
import 'package:clax/screens/Home/trusted_contacts.dart';
import 'package:clax/screens/Home/upfrontPricing.dart';
import 'package:clax/screens/Home/verification.dart';
import 'package:clax/screens/Home/wallet.dart';
import 'package:clax/screens/Home/yourAcc.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
                fontSize: 64, letterSpacing: -0.5, fontWeight: FontWeight.w200),
            headline3: TextStyle(
                fontSize: 51, letterSpacing: 0, fontWeight: FontWeight.w400),
            headline4: TextStyle(
                fontSize: 36, letterSpacing: 0.25, fontWeight: FontWeight.w400),
            headline5: TextStyle(
                fontSize: 25, letterSpacing: 0, fontWeight: FontWeight.w400),
            headline6: TextStyle(
                fontSize: 21, letterSpacing: 0.15, fontWeight: FontWeight.w600),
            subtitle1: TextStyle(
                fontSize: 17, letterSpacing: 0.15, fontWeight: FontWeight.w400),
            subtitle2: TextStyle(
                fontSize: 15, letterSpacing: 0.1, fontWeight: FontWeight.w600),
            bodyText1: TextStyle(
                fontSize: 17, letterSpacing: 0.5, fontWeight: FontWeight.w400),
            bodyText2: TextStyle(
                fontSize: 15, letterSpacing: 0.25, fontWeight: FontWeight.w400),
            button: TextStyle(
                fontSize: 15, letterSpacing: 1.25, fontWeight: FontWeight.w600),
            caption: TextStyle(
                fontSize: 13, letterSpacing: 0.4, fontWeight: FontWeight.w400),
            overline: TextStyle(
                fontSize: 11, letterSpacing: 1.5, fontWeight: FontWeight.w400),
          ),
        ),
        // initialRoute: '/login',
        routes: {
          '/Main': (context) => Login(),
          Login.routeName: (context) => Login(),
          RegisterForm.routeName: (context) => RegisterForm(),
          ForgetPass.routeName: (context) => ForgetPass(),
          Verification.routeName: (context) => Verification(),
          Tabs.routeName: (context) => Tabs(),
          Rides.routeName: (ctx) => Rides(),
          Settings.routeName: (ctx) => Settings(),
          Help.routeName: (ctx) => Help(),
          Pay.routeName: (ctx) => Pay(),
          FreeRides.routeName: (ctx) => FreeRides(),
          Account.routeName: (ctx) => Account(),
          Safety.routeName: (ctx) => Safety(),
          Family.routeName: (ctx) => Family(),
          Notifications.routeName: (ctx) => Notifications(),
          Signout.routeName: (ctx) => Signout(),
          Payments.routeName: (ctx) => Payments(),
          Bookings.routeName: (ctx) => Bookings(),
          Guide.routeName: (ctx) => Guide(),
          More.routeName: (ctx) => More(),
          YourAccount.routeName: (ctx) => YourAccount(),
          FamilyMembers.routeName: (ctx) => FamilyMembers(),
          TrustedContacts.routeName: (ctx) => TrustedContacts(),
          Members.routeName: (ctx) => Members(),
          History.routeName: (ctx) => History(),
          EVerify.routeName: (ctx) => EVerify(),
          CreditCard.routeName: (ctx) => CreditCard(),
          Cancellations.routeName: (ctx) => Cancellations(),
          UpFrontPricing.routeName: (ctx) => UpFrontPricing(),
          Wallet.routeName: (ctx) => Wallet(),
          PayOptions.routeName: (ctx) => PayOptions(),
          PromoCodes.routeName: (ctx) => PromoCodes(),
        },
        onUnknownRoute: (settings) {
          print(settings.arguments);
          return MaterialPageRoute(builder: (ctx) => NewTrip());
        },
        home: ChangeNotifierProvider(
          create: (context) => Auth(),
          child: LoadMainScreen(),
        ));
  }
}

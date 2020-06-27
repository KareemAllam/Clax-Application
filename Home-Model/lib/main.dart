//import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:ui';
import 'package:clax/screens/creditCard.dart';
import 'package:provider/provider.dart';
import './screens/Account.dart';
import 'package:flutter/material.dart';
import 'providers/profiles.dart';
import 'screens/Bookings.dart';
import 'screens/Components/family_members.dart';
import 'screens/Components/new_trip.dart';
import 'screens/Members.dart';
import 'screens/cancellations.dart';
import 'screens/components/Family.dart';
import 'screens/Guide.dart';
import 'screens/More.dart';
import 'screens/Notifications.dart';
import 'screens/Payments.dart';
import 'screens/Safety.dart';
import './config.dart' as application;
import 'screens/Signout.dart';
import 'screens/free_rides.dart';
import 'screens/help.dart';
import './screens/Clax.dart';
import 'screens/pay.dart';
import 'screens/Rahalatk.dart';
import 'screens/payOptions.dart';
import 'screens/promoCodes.dart';
import 'screens/settings.dart';
import 'screens/trusted_contacts.dart';
import 'screens/upfrontPricing.dart';
import 'screens/wallet.dart';
import 'screens/yourAcc.dart';
import 'widgets/history.dart';
import 'screens/verification.dart';

void main() => runApp(Clax());

class Clax extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => Profiles()),
        ChangeNotifierProvider.value(
          value: Profiles(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child,
          );
        },
        title: 'كلاكس',
        localizationsDelegates: application.localization,
        supportedLocales: application.languages,
        locale:
            application.local, // OR Locale('ar', 'AE') OR Other RTL locales,
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Color(0xffe3e8ee),
          dividerColor: Colors.black12,
          primaryColor: Colors.deepPurple,
          accentColor: Colors.amber,
          backgroundColor: Colors.white,
          secondaryHeaderColor: Colors.grey,
          primaryColorDark: Colors.deepPurple,
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
                fontSize: 21, letterSpacing: 0.15, fontWeight: FontWeight.w500),
            subtitle1: TextStyle(
                fontSize: 17, letterSpacing: 0.15, fontWeight: FontWeight.w400),
            subtitle2: TextStyle(
                fontSize: 15, letterSpacing: 0.1, fontWeight: FontWeight.w500),
            bodyText1: TextStyle(
                fontSize: 17, letterSpacing: 0.5, fontWeight: FontWeight.w400),
            bodyText2: TextStyle(
                fontSize: 15, letterSpacing: 0.25, fontWeight: FontWeight.w400),
            button: TextStyle(
                fontSize: 15, letterSpacing: 1.25, fontWeight: FontWeight.w500),
            caption: TextStyle(
                fontSize: 13, letterSpacing: 0.4, fontWeight: FontWeight.w400),
            overline: TextStyle(
                fontSize: 11, letterSpacing: 1.5, fontWeight: FontWeight.w400),
          ),
          buttonTheme: ButtonThemeData(
            padding: EdgeInsets.all(0),
          ),
        ),
        //home: NewTrip(),
        initialRoute: '/',
        routes: {
          '/': (ctx) => Tabs(),
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
          //FavTripCard.routeName: (ctx) => FavTripCard(),
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
      ),
    );
  }
}

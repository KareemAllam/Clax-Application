// Dart & Other Packages;
import 'package:clax/screens/Payments/Payment_HomeScreen.dart';
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// Providers
import 'package:clax/providers/Account.dart';
import 'package:clax/providers/Auth.dart';
import 'package:clax/providers/Complains.dart';
import 'package:clax/providers/Payments.dart';
import 'package:clax/providers/Trips.dart';
import 'package:clax/providers/Transactions.dart';
// Screens
import 'package:clax/screens/Home/Clax.dart';
import 'package:clax/screens/Login/Login.dart';
import 'package:clax/screens/Login/RegisterForm.dart';
import 'package:clax/screens/Login/LoadMainScreen.dart';
import 'package:clax/screens/Login/Verification.dart';
import 'package:clax/screens/Login/ForgotPassword.dart';
//// Home Screens
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
//// Payments Screens
import 'package:clax/screens/Payments/Complaint_Details.dart';
import 'package:clax/screens/Payments/complains_Historty.dart';
import 'package:clax/screens/Payments/Payment_Add.dart';
import 'package:clax/screens/Payments/Payment_PaypalWeb.dart';
import 'package:clax/screens/Payments/Complains_Screen.dart';
import 'package:clax/screens/Payments/Complain_Write.dart';
import 'package:clax/screens/Payments/Payment_History.dart';
import 'package:clax/screens/Payments/Payment_TransferMoney.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => AccountProvider()),
        Provider(create: (context) => ComplainsProvider()),
        Provider(create: (context) => TripsProvider()),
        Provider(create: (context) => TransactionsProvider()),
        Provider(create: (context) => PaymentsProvider()),
        ChangeNotifierProvider(create: (context) => AccountProvider()),
        ChangeNotifierProvider(create: (context) => ComplainsProvider()),
        ChangeNotifierProvider(create: (context) => TripsProvider()),
        ChangeNotifierProvider(create: (context) => TransactionsProvider()),
        ChangeNotifierProvider(create: (context) => PaymentsProvider())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('ar', 'AE')
          ], // OR Locale('ar', 'AE') OR Other RTL locales

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
          routes: {
            '/Main': (context) => Login(),
            Login.routeName: (context) => Login(),
            RegisterForm.routeName: (context) => RegisterForm(),
            ForgetPass.routeName: (context) => ForgetPass(),
            Verification.routeName: (context) => Verification(),
            // Home Model
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
            // Payment Model
            PaymentScreen.routeName: (BuildContext context) => PaymentScreen(),
            TransferMoney.routeName: (BuildContext context) => TransferMoney(),
            PaymentAdd.routeName: (BuildContext context) => PaymentAdd(),
            PaymentHistory.routeName: (BuildContext context) =>
                PaymentHistory(),
            Complaints.routeName: (BuildContext context) => new Complaints(),
            WriteAComplain.routeName: (BuildContext context) =>
                WriteAComplain(),
            ComplaintsHistory.routeName: (BuildContext context) =>
                ComplaintsHistory(),
            ComplainDetails.routeName: (BuildContext context) =>
                ComplainDetails(),
            PaypalWeb.routeName: (BuildContext context) => PaypalWeb(),
            // Test
          },
          onUnknownRoute: (settings) {
            return MaterialPageRoute(builder: (ctx) => NewTrip());
          },
          home: ChangeNotifierProvider(
            create: (context) => AuthProvider(),
            child: LoadMainScreen(),
          )),
    );
  }
}

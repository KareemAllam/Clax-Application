// Flutter's Material Components
import 'package:clax/providers/profiles.dart';
import 'package:flutter/material.dart';
// Dart & Other Packages
import 'package:provider/provider.dart';
// Screens
//// Authentication
import 'package:clax/screens/Login/LoadMainScreen.dart';
import 'package:clax/screens/Login/Login.dart';
import 'package:clax/screens/Login/Register.dart';
import 'package:clax/screens/Login/Verification.dart';
import 'package:clax/screens/Login/ForgotPassword.dart';
//// Home Screens
import 'package:clax/screens/Home/AccountOverview.dart';
import 'package:clax/screens/Home/Bookings.dart';
import 'package:clax/screens/Home/Components/Family.dart';
import 'package:clax/screens/Home/Components/family_members.dart';
import 'package:clax/screens/Home/Components/history.dart';
import 'package:clax/screens/Home/Free_Rides.dart';
import 'package:clax/screens/Home/Guide.dart';
import 'package:clax/screens/Home/Members.dart';
import 'package:clax/screens/Home/More.dart';
import 'package:clax/screens/Home/Notifications.dart';
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
import 'package:clax/screens/Home/EditAccount.dart';
//// Payments Screens
import 'package:clax/screens/Payments/Payment_HomeScreen.dart';
import 'package:clax/screens/Payments/Payment_Add.dart';
import 'package:clax/screens/Payments/Payment_PaypalWeb.dart';
import 'package:clax/screens/Payments/Payment_History.dart';
import 'package:clax/screens/Payments/Payment_TransferMoney.dart';
import 'package:clax/screens/Payments/Complaint_Details.dart';
import 'package:clax/screens/Payments/complains_Historty.dart';
import 'package:clax/screens/Payments/Complains_Screen.dart';
import 'package:clax/screens/Payments/Complain_Write.dart';
import 'package:clax/screens/MakeARide/Clax.dart';
//// Tracking Screens
import 'package:clax/screens/MakeARide/StartARide.dart';
import 'package:clax/screens/MakeARide/GoogleMap.dart';
import 'package:clax/screens/MakeARide/RidePickupLocation.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => LoadMainScreen(), settings: settings);
      case Login.routeName:
        return MaterialPageRoute(builder: (_) => Login(), settings: settings);
      // Home
      case Tabs.routeName:
        return MaterialPageRoute(builder: (_) => Tabs(), settings: settings);
      case StartARide.routeName:
        return MaterialPageRoute(
            builder: (_) => StartARide(), settings: settings);
      case RidePickLocation.routeName:
        return MaterialPageRoute(
            builder: (_) => RidePickLocation(), settings: settings);
      case MapPage.routeName:
        return MaterialPageRoute(builder: (_) => MapPage(), settings: settings);
      case RegisterForm.routeName:
        return MaterialPageRoute(
            builder: (_) => RegisterForm(), settings: settings);
      case Verification.routeName:
        return MaterialPageRoute(
            builder: (_) => Verification(), settings: settings);
      case ForgetPass.routeName:
        return MaterialPageRoute(
            builder: (_) => ForgetPass(), settings: settings);
      case Account.routeName:
        return MaterialPageRoute(builder: (_) => Account(), settings: settings);
      case Bookings.routeName:
        return MaterialPageRoute(
            builder: (_) => Bookings(), settings: settings);
      case Family.routeName:
        return MaterialPageRoute(builder: (_) => Family(), settings: settings);
      case FamilyMembers.routeName:
        return MaterialPageRoute(
            builder: (_) => FamilyMembers(), settings: settings);
      case History.routeName:
        return MaterialPageRoute(builder: (_) => History(), settings: settings);
      case FreeRides.routeName:
        return MaterialPageRoute(
            builder: (_) => FreeRides(), settings: settings);
      case Guide.routeName:
        return MaterialPageRoute(builder: (_) => Guide(), settings: settings);
      case Members.routeName:
        return MaterialPageRoute(builder: (_) => Members(), settings: settings);
      case More.routeName:
        return MaterialPageRoute(builder: (_) => More(), settings: settings);
      case Notifications.routeName:
        return MaterialPageRoute(
            builder: (_) => Notifications(), settings: settings);
      case Rides.routeName:
        return MaterialPageRoute(builder: (_) => Rides(), settings: settings);
      case Safety.routeName:
        return MaterialPageRoute(builder: (_) => Safety(), settings: settings);
      case Signout.routeName:
        return MaterialPageRoute(builder: (_) => Signout(), settings: settings);
      case Cancellations.routeName:
        return MaterialPageRoute(
            builder: (_) => Cancellations(), settings: settings);
      case CreditCard.routeName:
        return MaterialPageRoute(
            builder: (_) => CreditCard(), settings: settings);
      case Help.routeName:
        return MaterialPageRoute(builder: (_) => Help(), settings: settings);
      case PayOptions.routeName:
        return MaterialPageRoute(
            builder: (_) => PayOptions(), settings: settings);
      case Settings.routeName:
        return MaterialPageRoute(
            builder: (_) => Provider<ProfilesProvider>(
                  create: (settings) => ProfilesProvider(),
                  child: Settings(),
                ),
            settings: settings);
      case TrustedContacts.routeName:
        return MaterialPageRoute(
            builder: (_) => TrustedContacts(), settings: settings);
      case UpFrontPricing.routeName:
        return MaterialPageRoute(
            builder: (_) => UpFrontPricing(), settings: settings);

      case YourAccount.routeName:
        return MaterialPageRoute(
            builder: (_) => YourAccount(), settings: settings);
      case PromoCodes.routeName:
        return MaterialPageRoute(
            builder: (_) => PromoCodes(), settings: settings);
      // Payment
      case PaymentScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => PaymentScreen(), settings: settings);
      case ComplainDetails.routeName:
        return MaterialPageRoute(
            builder: (_) => ComplainDetails(), settings: settings);
      case ComplaintsHistory.routeName:
        return MaterialPageRoute(
            builder: (_) => ComplaintsHistory(), settings: settings);
      case PaymentAdd.routeName:
        return MaterialPageRoute(
            builder: (_) => PaymentAdd(), settings: settings);
      case PaypalWeb.routeName:
        return MaterialPageRoute(
            builder: (_) => PaypalWeb(), settings: settings);
      case Complains.routeName:
        return MaterialPageRoute(
            builder: (_) => Complains(), settings: settings);
      case WriteAComplain.routeName:
        return MaterialPageRoute(
            builder: (_) => WriteAComplain(), settings: settings);
      case PaymentHistory.routeName:
        return MaterialPageRoute(
            builder: (_) => PaymentHistory(), settings: settings);
      case TransferMoney.routeName:
        return MaterialPageRoute(
            builder: (_) => TransferMoney(), settings: settings);
      case PaypalWeb.routeName:
        return MaterialPageRoute(
            builder: (_) => PaypalWeb(), settings: settings);
      // Tracking
      // case TripDetails.routeName:
      //   return MaterialPageRoute(builder: (_) => TripDetails(),settings: settings);
      // case MapPage.routeName:
      //   return MaterialPageRoute(builder: (_) => MapPage(),settings: settings);
      // case LinesPage.routeName:
      //   return MaterialPageRoute(builder: (_) => LinesPage(),settings: settings);
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}

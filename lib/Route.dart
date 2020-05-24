// Flutter's Material Components
import 'package:clax/providers/profiles.dart';
import 'package:flutter/material.dart';
// Dart & Other Packages
import 'package:provider/provider.dart';
// Screens
//// Authentication
import 'package:clax/screens/Login/LoadMainScreen.dart';
import 'package:clax/screens/Home/Clax.dart';
import 'package:clax/screens/Login/Login.dart';
import 'package:clax/screens/Login/Register.dart';
import 'package:clax/screens/Login/Verification.dart';
import 'package:clax/screens/Login/ForgotPassword.dart';
//// Home Screens
import 'package:clax/screens/Home/StartARide.dart';
import 'package:clax/screens/Home/RideInfo.dart';
import 'package:clax/screens/Home/GoogleMap.dart';
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
//// Tracking Screens
// import 'package:clax/screens/Tracking/Map.dart';
// import 'package:clax/screens/Tracking/LinesPage.dart';
// import 'package:clax/screens/Tracking/TripDetails.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoadMainScreen());
      case Login.routeName:
        return MaterialPageRoute(builder: (_) => Login());
      // Home
      case Tabs.routeName:
        return MaterialPageRoute(builder: (_) => Tabs());
      case StartARide.routeName:
        return MaterialPageRoute(builder: (_) => StartARide());
      case RideInfo.routeName:
        return MaterialPageRoute(
            builder: (_) => RideInfo(), settings: settings);
      case MapPage.routeName:
        return MaterialPageRoute(builder: (_) => MapPage());
      case RegisterForm.routeName:
        return MaterialPageRoute(builder: (_) => RegisterForm());
      case Verification.routeName:
        return MaterialPageRoute(builder: (_) => Verification());
      case ForgetPass.routeName:
        return MaterialPageRoute(builder: (_) => ForgetPass());
      case Account.routeName:
        return MaterialPageRoute(builder: (_) => Account());
      case Bookings.routeName:
        return MaterialPageRoute(builder: (_) => Bookings());
      case Family.routeName:
        return MaterialPageRoute(builder: (_) => Family());
      case FamilyMembers.routeName:
        return MaterialPageRoute(builder: (_) => FamilyMembers());
      case History.routeName:
        return MaterialPageRoute(builder: (_) => History());
      case FreeRides.routeName:
        return MaterialPageRoute(builder: (_) => FreeRides());
      case Guide.routeName:
        return MaterialPageRoute(builder: (_) => Guide());
      case Members.routeName:
        return MaterialPageRoute(builder: (_) => Members());
      case More.routeName:
        return MaterialPageRoute(builder: (_) => More());
      case Notifications.routeName:
        return MaterialPageRoute(builder: (_) => Notifications());
      case Rides.routeName:
        return MaterialPageRoute(builder: (_) => Rides());
      case Safety.routeName:
        return MaterialPageRoute(builder: (_) => Safety());
      case Signout.routeName:
        return MaterialPageRoute(builder: (_) => Signout());
      case Cancellations.routeName:
        return MaterialPageRoute(builder: (_) => Cancellations());
      case CreditCard.routeName:
        return MaterialPageRoute(builder: (_) => CreditCard());
      case Help.routeName:
        return MaterialPageRoute(builder: (_) => Help());
      case PayOptions.routeName:
        return MaterialPageRoute(builder: (_) => PayOptions());
      case Settings.routeName:
        return MaterialPageRoute(
            builder: (_) => Provider<ProfilesProvider>(
                  create: (settings) => ProfilesProvider(),
                  child: Settings(),
                ));
      case TrustedContacts.routeName:
        return MaterialPageRoute(builder: (_) => TrustedContacts());
      case UpFrontPricing.routeName:
        return MaterialPageRoute(builder: (_) => UpFrontPricing());

      case YourAccount.routeName:
        return MaterialPageRoute(builder: (_) => YourAccount());
      case PromoCodes.routeName:
        return MaterialPageRoute(builder: (_) => PromoCodes());
      // Payment
      case PaymentScreen.routeName:
        return MaterialPageRoute(builder: (_) => PaymentScreen());
      case ComplainDetails.routeName:
        return MaterialPageRoute(builder: (_) => ComplainDetails());
      case ComplaintsHistory.routeName:
        return MaterialPageRoute(builder: (_) => ComplaintsHistory());
      case PaymentAdd.routeName:
        return MaterialPageRoute(builder: (_) => PaymentAdd());
      case PaypalWeb.routeName:
        return MaterialPageRoute(builder: (_) => PaypalWeb());
      case Complains.routeName:
        return MaterialPageRoute(builder: (_) => Complains());
      case WriteAComplain.routeName:
        return MaterialPageRoute(builder: (_) => WriteAComplain());
      case PaymentHistory.routeName:
        return MaterialPageRoute(builder: (_) => PaymentHistory());
      case TransferMoney.routeName:
        return MaterialPageRoute(builder: (_) => TransferMoney());
      case PaypalWeb.routeName:
        return MaterialPageRoute(builder: (_) => PaypalWeb());
      // Tracking
      // case TripDetails.routeName:
      //   return MaterialPageRoute(builder: (_) => TripDetails());
      // case MapPage.routeName:
      //   return MaterialPageRoute(builder: (_) => MapPage());
      // case LinesPage.routeName:
      //   return MaterialPageRoute(builder: (_) => LinesPage());
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

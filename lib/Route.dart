// Flutter's Material Components
import 'package:flutter/material.dart';
// Dart & Other Packages
import 'package:provider/provider.dart';
// Providers
import 'package:clax/providers/Profile.dart';
// Screens
//// Authentication
import 'package:clax/screens/Login/Login.dart';
import 'package:clax/screens/Login/Register.dart';
import 'package:clax/screens/Login/Register2.dart';
import 'package:clax/screens/Login/Verification.dart';
import 'package:clax/screens/Login/ForgotPassword.dart';

//// Settings
import 'package:clax/screens/Settings/AccountOverview.dart';
import 'package:clax/screens/Settings/Notifications.dart';
import 'package:clax/screens/Settings/Settings.dart';
import 'package:clax/screens/Settings/EditAccount.dart';
import 'package:clax/screens/Settings/Safety.dart';
import 'package:clax/screens/Settings/TrustedContacts.dart';

//// Help
import 'package:clax/screens/Help/Guide.dart';
import 'package:clax/screens/Help/More.dart';
import 'package:clax/screens/Help/Help.dart';
import 'package:clax/screens/Help/Cancellations.dart';
import 'package:clax/screens/Help/UpfrontPricing.dart';
import 'package:clax/screens/Help/PromoCodes.dart';

//// Home Screens
import 'package:clax/screens/Home/Rahalatk.dart';

//// Complains
import 'package:clax/screens/Complains/Complaint_Details.dart';
import 'package:clax/screens/Complains/Complains_Screen.dart';
import 'package:clax/screens/Complains/Complain_Write.dart';
import 'package:clax/screens/Complains/Complains_Historty.dart';

//// Payments Screens
import 'package:clax/screens/Payments/Payment_HomeScreen.dart';
import 'package:clax/screens/Payments/Payment_History.dart';

//// Tracking Screens
import 'package:clax/screens/LandingPage.dart';
import 'package:clax/screens/MakeARide/TripEnded.dart';
import 'package:clax/screens/MakeARide/Working.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => LandingPage(), settings: settings);

      // Clax
      case LandingPage.routeName:
        return MaterialPageRoute(
            builder: (_) => LandingPage(), settings: settings);
      case Working.routeName:
        return MaterialPageRoute(builder: (_) => Working(), settings: settings);
      case TripEnded.routeName:
        return MaterialPageRoute(
            builder: (_) => TripEnded(), settings: settings);

      // Login & Registration
      case Login.routeName:
        return MaterialPageRoute(builder: (_) => Login(), settings: settings);
      case RegisterForm.routeName:
        return MaterialPageRoute(
            builder: (_) => RegisterForm(), settings: settings);
      case RegisterForm2.routeName:
        return MaterialPageRoute(
            builder: (_) => RegisterForm2(), settings: settings);
      case Verification.routeName:
        return MaterialPageRoute(
            builder: (_) => Verification(), settings: settings);
      case ForgetPass.routeName:
        return MaterialPageRoute(
            builder: (_) => ForgetPass(), settings: settings);

      // Settings
      case Account.routeName:
        return MaterialPageRoute(builder: (_) => Account(), settings: settings);
      case Guide.routeName:
        return MaterialPageRoute(builder: (_) => Guide(), settings: settings);
      case More.routeName:
        return MaterialPageRoute(builder: (_) => More(), settings: settings);
      case Rides.routeName:
        return MaterialPageRoute(builder: (_) => Rides(), settings: settings);
      case Safety.routeName:
        return MaterialPageRoute(builder: (_) => Safety(), settings: settings);
      case Cancellations.routeName:
        return MaterialPageRoute(
            builder: (_) => Cancellations(), settings: settings);
      case Help.routeName:
        return MaterialPageRoute(builder: (_) => Help(), settings: settings);
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
      case AccountOverview.routeName:
        return MaterialPageRoute(
            builder: (_) => AccountOverview(), settings: settings);
      case Notifications.routeName:
        return MaterialPageRoute(
            builder: (_) => Notifications(), settings: settings);

      // Payment
      case PaymentScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => PaymentScreen(), settings: settings);
      case PaymentHistory.routeName:
        return MaterialPageRoute(
            builder: (_) => PaymentHistory(), settings: settings);

      // Home
      case PromoCodes.routeName:
        return MaterialPageRoute(
            builder: (_) => PromoCodes(), settings: settings);

      // Complaints
      case ComplainDetails.routeName:
        return MaterialPageRoute(
            builder: (_) => ComplainDetails(), settings: settings);
      case ComplaintsHistory.routeName:
        return MaterialPageRoute(
            builder: (_) => ComplaintsHistory(), settings: settings);
      case Complains.routeName:
        return MaterialPageRoute(
            builder: (_) => Complains(), settings: settings);
      case WriteAComplain.routeName:
        return MaterialPageRoute(
            builder: (_) => WriteAComplain(), settings: settings);

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

// Dart & Other Packages
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Providers
import 'package:clax/providers/Auth.dart';
// import 'package:clax/providers/Trips.dart';
// import 'package:clax/providers/Payment.dart';
// import 'package:clax/providers/Profile.dart';
// import 'package:clax/providers/CurrentTrip.dart';
// import 'package:clax/providers/Transactions.dart';
// Screens
import 'package:clax/screens/LandingPage.dart';
import 'package:clax/screens/Home/Rahalatk.dart';
import 'package:clax/screens/Help/Help.dart';
import 'package:clax/screens/Settings/Settings.dart';
import 'package:clax/screens/Complains/Complains_Screen.dart';
import 'package:clax/screens/Payments/Payment_HomeScreen.dart';
import 'package:clax/screens/Login/Login.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  List<Map<String, dynamic>> menu = [
    {
      "title": 'كلاكس',
      "icon": Icons.local_taxi,
      "route": LandingPage.routeName
    },
    {"title": 'رحلاتك', "icon": Icons.calendar_today, "route": Rides.routeName},
    {
      "title": 'الدفع',
      "icon": Icons.attach_money,
      "route": PaymentScreen.routeName
    },
    {"title": 'الشكاوي', "icon": Icons.feedback, "route": Complains.routeName},
    {"title": 'الإعدادات', "icon": Icons.settings, "route": Settings.routeName},
    {"title": 'مساعدة', "icon": Icons.help, "route": Help.routeName},
  ];

  void logout() async {
    bool logout =
        await Provider.of<AuthProvider>(context, listen: false).logOut();
    if (logout) {
      // await Provider.of<PaymentProvider>(context, listen: false).init();
      // await Provider.of<ProfilesProvider>(context, listen: false).init();
      // await Provider.of<TripsProvider>(context, listen: false).initialize();
      // await Provider.of<TransactionsProvider>(context, listen: false)
      //     .initialize();
      // await Provider.of<CurrentTripProvider>(context, listen: false).init();

      // Pop Current Screens
      Navigator.popUntil(context, (route) {
        if (route.settings.name == LandingPage.routeName) return true;
        return false;
      });
      // Push Login Screen
      Navigator.of(context).pushReplacementNamed(Login.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget buildListTile(String title, IconData icon, Function tapHandler) =>
        Container(
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.black12))),
          child: ListTile(
            leading:
                Icon(icon, size: 26, color: Theme.of(context).primaryColor),
            title: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.w600, color: Colors.black45),
            ),
            onTap: tapHandler,
          ),
        );

    return SafeArea(
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'assets/images/taxi.png',
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            ...menu.map((index) => buildListTile(
                  index['title'],
                  index['icon'],
                  () {
                    // Get Current Route Name
                    String currentRoute = ModalRoute.of(context).settings.name;
                    // () => Clax
                    if (index['route'] == LandingPage.routeName) {
                      // Clax => Clax
                      if (currentRoute == LandingPage.routeName) {
                        // Dismiss Drawer
                        Navigator.of(context).pop();
                        return;
                      } else {
                        // Dismiss Drawer
                        Navigator.of(context).pop();
                        // Item => Clax
                        Navigator.of(context).pop();
                        // Navigator.of(context)
                        //     .pop(index['route']);
                        return;
                      }
                    }
                    // Item => Item
                    else if (currentRoute == index['route']) {
                      // Dismiss Drawer
                      Navigator.of(context).pop();
                      return;
                    }
                    // Navigating to Different Screen
                    if (currentRoute == LandingPage.routeName) {
                      // Dismiss Drawer
                      Navigator.of(context).pop();
                      // Navigate to Screen
                      Navigator.of(context).pushNamed(index['route']);
                    }
                    // "Item => Item2"
                    else {
                      // Dismiss Drawer
                      Navigator.of(context).pop();
                      // Navigate to Screen
                      Navigator.of(context)
                          .pushReplacementNamed(index['route']);
                    }
                  },
                )),
            Spacer(),
            buildListTile(
              "تسجيل الخروج",
              Icons.exit_to_app,
              logout,
            )
          ],
        ),
      ),
    );
  }
}

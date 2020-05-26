// Dart & Other Packages
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Providers
import 'package:clax/providers/Auth.dart';

// Screens
import 'package:clax/screens/MakeARide/Clax.dart';
import 'package:clax/screens/Login/SplashScreen.dart';
import 'package:clax/screens/Login/Login.dart';

class LoadMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    changeScreen() async {
      String data = await Provider.of<AuthProvider>(context, listen: false)
          .getSharedPrefrence();
      data != null
          ? Navigator.of(context).pushReplacementNamed(Tabs.routeName)
          : Navigator.of(context).pushReplacementNamed(Login.routeName);
    }

    changeScreen();
    return SplashScreen();
  }
}

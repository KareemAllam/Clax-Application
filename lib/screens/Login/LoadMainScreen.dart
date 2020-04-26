// Dart & Other Packages
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Providers
import 'package:clax/providers/Auth.dart';
// Screens
import 'package:clax/screens/Home/Clax.dart';
import 'package:clax/screens/Login/SplashScreen.dart';
import 'package:clax/screens/Login/Login.dart';

class LoadMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<AuthProvider>(context).getSharedPrefrence(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // log error to console
          if (snapshot.error != null) {
            print("error");
            return Text(snapshot.error.toString());
          }
          // redirect to the proper page, pass the user into the
          // `HomePage` so we can display the user email in welcome msg
          return snapshot.data == null ? Tabs() : Login();
        } else {
          // show loading indicator
          return SplashScreen();
        }
      },
    );
  }
}

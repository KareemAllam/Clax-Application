// Dart & Other Packages
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Providers
import 'package:clax/providers/Auth.dart';
// Screens
import 'package:clax/screens/ClaxRoot.dart';
import 'package:clax/screens/Login/Login.dart';

class Authentication extends StatefulWidget {
  static const routeName = 'Authentication';
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    // Check Authentication
    String data = await Provider.of<AuthProvider>(context, listen: false)
        .checkAuthentication();
    data != null
        // Navigate to Home Screen
        ? Navigator.of(context).pushNamed(ClaxRoot.routeName)
        // Navigate to Login Screen
        : Navigator.of(context).pushNamed(Login.routeName);
  }

  @override
  Widget build(BuildContext context) {
    // Show Splash Screen
    return Container(
      alignment: Alignment.center,
      color: Theme.of(context).primaryColor,
      child: GestureDetector(
        onTap: Navigator.of(context).pop,
        child: Image.asset(
          'assets/images/logo.png',
          height: 300,
        ),
      ),
    );
  }
}

// Dart & Other Packages
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Providers
import 'package:clax/providers/Payment.dart';
// import 'package:clax/providers/CurrentTrip.dart';
// import 'package:clax/providers/Map.dart';
// // Screens
// import 'package:clax/screens/MakeARide/GoogleMap.dart';
// import 'package:clax/screens/MakeARide/RideConfig.dart';

class NotificationHandler {
  BuildContext context;
  void handle(BuildContext navigator, Map<String, dynamic> message) async {
    print(ModalRoute.of(navigator).settings.name);
    context = navigator;
    String type = message['data']['type'];
    switch (type) {
      case "driverArrived":
        print("driverArrived");
        // await driverArrived(message['data']['driverId']);
        break;
      case "offer":
        offer(message['data']['discount']);
        break;
      default:
      // Default FCM Action
    }
  }

  // Future driverArrived(String driverId) async {
  //   // Retreive DriverID
  //   String _driverId = driverId;
  //   await Provider.of<CurrentTripProvider>(context, listen: false)
  //       .setDriverInfo(_driverId);
  //   Provider.of<MapProvider>(context, listen: false).setDriverId = _driverId;
  //   Provider.of<PaymentProvider>(context, listen: false).setBalance =
  //       -tripPrice;
  //   // Exit Waiting Screen
  //   // Github Solution: https://stackoverflow.com/questions/50817086/how-to-check-which-the-current-route-is/50817399
  //   if (!ModalRoute.of(context).isCurrent) {
  //     Navigator.of(context).popUntil((route) {
  //       if (route.settings.name == StartARide.routeName) return false;
  //       return true;
  //     });
  //   }
  //   Navigator.of(context).pushNamed(MapPage.routeName);
  // }

  void offer(dynamic discount) {
    double offerDiscount = double.parse(discount.toString());
    Provider.of<PaymentProvider>(context).setDiscount = offerDiscount;
  }
}

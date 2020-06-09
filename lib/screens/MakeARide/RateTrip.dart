// Dart & Other Pacakges
import 'dart:math';
import 'package:provider/provider.dart';
// Flutter Material Components
import 'package:flutter/material.dart';
// Models
import 'package:clax/models/Trip.dart';
import 'package:clax/models/Bill.dart';
import 'package:clax/models/Driver.dart';
import 'package:clax/models/Station.dart';
// Providers
import 'package:clax/providers/Trips.dart';
import 'package:clax/providers/Payment.dart';
// Screens
import 'package:clax/screens/MakeARide/Clax.dart';
// Providers
import 'package:clax/providers/CurrentTrip.dart';

class RateTrip extends StatefulWidget {
  static const routeName = '/rateTrip';
  @override
  _RateTripState createState() => _RateTripState();
}

class _RateTripState extends State<RateTrip> {
  double width;
  double height;
  String title;
  int driverRate = 0;
  bool feedbackProvided = false;
  TextEditingController _description = TextEditingController();

  Future submitForm(bool userSubmitted) async {
    // String driverId = Provider.of<CurrentTripProvider>(context, listen: false)
    //     .currentDriverInfo['driverId'];
    // Map<String, dynamic> body = {
    //   'driverId': driverId,
    //   'rate': driverRate,
    //   'description': _description.text
    // };
    // await Api.post('pairing/driverRate', json.encode(body));

    Map<String, dynamic> tripInfo =
        Provider.of<CurrentTripProvider>(context, listen: false)
            .currentTripInfo;

    // Adjusting Payment History
    BillModel bill = BillModel(
        amount: tripInfo["finalPrice"],
        date: DateTime.now(),
        type: "Pay",
        description: tripInfo['station']['name']);
    await Provider.of<PaymentProvider>(context, listen: false).add(bill);

    // Adjusting Trips History
    Trip _trip = Trip(
        station: StationModel.fromJson(tripInfo['station']),
        driver: DriverModel.fromJson(tripInfo),
        id: Random(2).toString(),
        lineId: tripInfo['lindId'],
        price: tripInfo['finalPrice'],
        start: tripInfo['start'],
        rate: userSubmitted ? driverRate * 10 : 30);

    await Provider.of<TripsProvider>(context, listen: false).addTrip(_trip);

    // Adjusting Payment Balance
    Provider.of<PaymentProvider>(context, listen: false).setBalance =
        -tripInfo["finalPrice"];

    // Clear Trip State
    await Provider.of<CurrentTripProvider>(context, listen: false)
        .clearTripInfo();

    // Return to Main Screen
    Navigator.of(context).popUntil((route) {
      if (route.settings.name == Clax.routeName) return true;
      return false;
    });
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    title = "معلومات اضافية";
  }

  @override
  void dispose() {
    _description.dispose();
    super.dispose();
  }

  Widget star(int i) {
    return IconButton(
        padding: EdgeInsets.all(0),
        icon: Icon(driverRate >= i ? Icons.star : Icons.star_border,
            color: Theme.of(context).accentColor, size: 30),
        onPressed: () {
          setState(() {
            driverRate = i;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Widget stars = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[for (int i = 1; i <= 5; i++) star(i)]);
    return WillPopScope(
      onWillPop: () async {
        await submitForm(false);
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "تقيم السائق",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Container(
                height: height - height * 0.109,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Stars Raiting
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                right: width * 0.05,
                                bottom: height * 0.0054,
                                top: 20),
                            child: Text(
                              "قيم السائق",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                driverRate = 0;
                              });
                            },
                            child: Container(
                                margin: EdgeInsets.only(
                                    top: height * 0.007, bottom: width * 0.05),
                                alignment: Alignment.center,
                                color: Colors.white,
                                child: stars),
                          )
                        ]),

                    // Decorated TextField
                    Column(mainAxisSize: MainAxisSize.min, children: [
                      Container(
                          padding: EdgeInsets.only(
                              right: width * 0.05, bottom: height * 0.0054),
                          width: double.infinity,
                          child: Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(fontWeight: FontWeight.bold),
                          )),
                      Container(
                        margin: EdgeInsets.only(top: height * 0.007),
                        padding: EdgeInsets.symmetric(
                            vertical: height * 0.0054,
                            horizontal: width * 0.05),
                        height: height * 0.3,
                        child: TextField(
                          enabled: true,
                          maxLength: 250,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: _description,
                          cursorColor: Theme.of(context).primaryColor,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Color(0xff212121)),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            hintText: "تفاصيل اخرى عن الرحلة",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Colors.grey),
                            counter: SizedBox(),
                            icon: Icon(
                              Icons.power_input,
                              color: Theme.of(context).primaryColor,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          border: Border.all(
                              color: Theme.of(context).secondaryHeaderColor,
                              width: 0.5),
                        ),
                      ),
                    ]),
                    Spacer(),
                    GestureDetector(
                        onTap: () => submitForm(true),
                        child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            alignment: Alignment.center,
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              "تقيم",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                            )))
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

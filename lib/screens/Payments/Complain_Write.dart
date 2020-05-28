// Dart & Other Packages
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Providers
import 'package:clax/providers/Complains.dart';
import 'package:clax/providers/Trips.dart';
// Models
import 'package:clax/models/Trip.dart';
// Screens
import 'package:clax/screens/Payments/Components/ComplainTDropDown.dart';
import 'package:clax/screens/Payments/Components/TripsDropDown.dart';
// Widgets
import 'package:clax/widgets/404.dart';
import 'package:clax/widgets/FormGeneral.dart';
import 'package:clax/widgets/FormInput.dart';
import 'package:clax/widgets/LoadingButton.dart';

// Fetched States
// 0 : Loading
// 1 : Internet Error
// 2 : Success

class WriteAComplain extends StatefulWidget {
  static const routeName = '/complaints/writeAComplain';
  @override
  _WriteAComplainState createState() => _WriteAComplainState();
}

class _WriteAComplainState extends State<WriteAComplain> {
  Trip selectedTrip;
  String complainType;
  int fetched = 0;
  TextEditingController description = TextEditingController();
  String tripPlaceholder = "حدد رحلة من رحلاتك السابقة";
  String typePlaceHolder = "حدد نوع الشكوى المناسب";
  String descriptionPlaceHolder = "حد اقصى 250 كملة";
  bool enabled = true;
  void changeStateTrip(Trip value) {
    selectedTrip = value;
  }

  void changeStateComplainType(String value) {
    complainType = value;
  }

  void checkState() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // Check Trips Count
        setState(() {
          fetched = 2;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        fetched = 1;
      });
    }
  }

  Future<int> submitForm() async {
    // Loading Animaion Enabling
    setState(() {
      enabled = !enabled;
    });

    // Form Validation
    int error = 0;
    if (complainType == null) {
      setState(() {
        error = 1;
        typePlaceHolder = 'من فضلك، اختر نوع شكوى مناسب';
      });
    } else
      typePlaceHolder = "حدد نوع الشكوى المناسب";
    if (selectedTrip == null) {
      setState(() {
        error = 1;
        tripPlaceholder = "من فضلك، اختر رحلة";
      });
    } else
      tripPlaceholder = "حدد رحلة من رحلاتك السابقة";
    if (description.text.length == 0) {
      setState(() {
        error = 1;
        descriptionPlaceHolder = "من فضلك، اوصف المشكلة";
      });
    } else
      descriptionPlaceHolder = "حد اقصى 250 كملة";

    if (error == 1) {
      setState(() {
        enabled = true;
        error = 0;
      });
      return 500;
    }

    Map<String, dynamic> body = {
      '_trip': selectedTrip.id,
      'text': description.text,
      "from_passenger": "true"
    };
    bool result =
        await Provider.of<ComplainsProvider>(context, listen: false).add(body);

    if (result) {
      setState(() {
        fetched = 2;
      });
      return 200;
    }
    return 404;
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    checkState();
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () async {
                  bool result =
                      await Provider.of<TripsProvider>(context).serverData();
                  if (!result)
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "تعذر الوصول للإنترنت. تأكد من اتصالك بالإنترنت و حاول مره اخرى.",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(color: Colors.white))));
                }),
          )
        ],
        elevation: 0.0,
        title: Text(
          'اكتب شكوى جديدة',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white),
        ),
      ),
      body: fetched == 0 // Loading
          ? SpinKitChasingDots(color: Theme.of(context).primaryColor)
          : fetched == 1 // No Internet Connection
              ? Center(
                  child: FourOFour(press: () {
                    checkState();
                  }),
                )
              : GestureDetector(
                  // Connected to Internet
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: ListView(children: [
                    SizedBox(height: height * 0.02),
                    FormGeneral(
                      title: "اختار رحلة:",
                      placeholder: tripPlaceholder,
                      widget: TripsDropDownMenu(changeStateTrip),
                    ),
                    SizedBox(height: height * 0.02),
                    FormGeneral(
                      title: "نوع الشكوى:",
                      placeholder: typePlaceHolder,
                      widget: ComplainsTypeDropdown(changeStateComplainType),
                      // widget: Text(""),
                    ),
                    SizedBox(height: height * 0.02),
                    FormInput(
                        title: "اوصف الشكوى",
                        placeholder: descriptionPlaceHolder,
                        description: description),
                    LoadingButton(
                      label: "قدم شكوى",
                      handleTap: submitForm,
                    ),
                  ]),
                ),
    );
  }
}

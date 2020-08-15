// Dart & Other Packages
import 'dart:convert';
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Providers
import 'package:clax/providers/Complains.dart';
import 'package:clax/providers/Trips.dart';
// Models
import 'package:clax/models/Trip.dart';
import 'package:clax/models/Error.dart';
// Components
import 'package:clax/screens/Complains/Components/TripsDropDown.dart';
// import 'package:clax/screens/Complains/Components/ComplainTDropDown.dart';
// Widgets
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
  bool enabled = true;

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  bool tripRelated = false;
  String titlePlaceholder = "ما هو موضوع الشكوى؟";
  String tripPlaceholder = "حدد رحلة من رحلاتك السابقة";
  String descriptionPlaceHolder = "حد اقصى 250 كملة";

  void changeStateTrip(Trip value) {
    selectedTrip = value;
  }

  Future<ServerResponse> submitForm() async {
    // Loading Animaion Enabling
    setState(() {
      enabled = !enabled;
    });

    // Form Validation
    int error = 0;
    if (title.text.length == 0) {
      error = 1;
      titlePlaceholder = 'من فضلك، اختر عنوان مناسب للشكوى';
    } else
      titlePlaceholder = "ما هو موضوع الشكوى؟";
    if (tripRelated && selectedTrip == null) {
      error = 1;
      tripPlaceholder = "من فضلك، اختر رحلة";
    } else
      tripPlaceholder = "حدد رحلة من رحلاتك السابقة";
    if (description.text.length == 0) {
      error = 1;
      descriptionPlaceHolder = "من فضلك، اوصف المشكلة";
    } else
      descriptionPlaceHolder = "حد اقصى 250 كملة";

    if (error == 1) {
      setState(() {
        enabled = true;
        error = 0;
      });
      return ServerResponse(status: false, message: "");
    }

    Map<String, dynamic> body = {
      "subject": title.text,
      'text': description.text,
      "from_passenger": true
    };

    if (tripRelated) {
      body['_trip'] = selectedTrip.id;
    }

    ServerResponse result =
        await Provider.of<ComplainsProvider>(context, listen: false)
            .add(json.encode(body), selectedTrip: selectedTrip ?? null);

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () async {
                  bool result =
                      await Provider.of<TripsProvider>(context, listen: false)
                          .serverData();
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
      body: GestureDetector(
        // Connected to Internet
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: ListView(
          children: [
            SizedBox(height: 16),
            Container(
                padding: EdgeInsets.only(right: 16, bottom: 8),
                width: double.infinity,
                child: Text(
                  "عنوان الشكوى",
                  style: Theme.of(context).textTheme.subtitle2,
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                enabled: true,
                maxLength: 250,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: title,
                cursorColor: Theme.of(context).primaryColor,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Color(0xff212121)),
                decoration: InputDecoration(
                  counterText: "",
                  // contentPadding: EdgeInsets.all(0),
                  hintText: titlePlaceholder,
                  hintStyle: titlePlaceholder.contains("من")
                      ? Theme.of(context).textTheme.bodyText2.copyWith(
                            color: Theme.of(context).primaryColor,
                          )
                      : Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.format_quote,
                  ),
                  border: InputBorder.none,
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                border: Border.all(
                    color: Theme.of(context).secondaryHeaderColor, width: 0.5),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  if (!tripRelated)
                    Padding(
                      padding: EdgeInsets.only(right: 16, top: 4),
                      child: GestureDetector(
                        onTap: () => setState(() {
                          tripRelated = true;
                        }),
                        child: Text(
                          "الشكوى بخصوص رحلة ما؟",
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (tripRelated)
              Column(
                children: <Widget>[
                  SizedBox(height: height * 0.02),
                  FormGeneral(
                    title: "اختار رحلة:",
                    widget: TripsDropDownMenu(
                        changeStateTrip,
                        () => setState(() => tripRelated = false),
                        tripPlaceholder),
                  ),
                ],
              ),
            SizedBox(height: height * 0.02),
            FormInput(
                title: "اوصف الشكوى",
                placeholder: descriptionPlaceHolder,
                description: description),
            Builder(
              builder: (context) => LoadingButton(
                label: "قدم شكوى",
                handleTap: () async {
                  ServerResponse result = await submitForm();
                  if (result.status)
                    Navigator.of(context).pop();
                  else if (result.message != '')
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          result.message,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

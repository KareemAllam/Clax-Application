// Dart & Other Packages
import 'package:clax/models/Error.dart';
import 'package:provider/provider.dart';
import 'package:contact_picker/contact_picker.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Models
import 'package:clax/models/Name.dart';
// Utils
import 'package:clax/utils/nameAdjustment.dart';
// Providers
import 'package:clax/providers/Transactions.dart';
import 'package:clax/providers/Profile.dart';
// Widgets
import 'package:clax/widgets/LoadingButton.dart';
import 'package:clax/widgets/FormGeneral.dart';

// 0: Waiting for Input
// 1: Form Error
// 2: User Doesn't Exist
// other: Success

class Loanee extends StatefulWidget {
  @override
  _LoaneeState createState() => _LoaneeState();
}

class _LoaneeState extends State<Loanee> {
  TextEditingController _amountController = TextEditingController();
  ContactPicker _contactPicker = new ContactPicker();
  String contactPlaceholder = 'حدد الشخص اللي هتستلف منه';
  String amountPlaceholder = "حد اقصى 99 جنيه";
  bool word = false;
  bool enabled = true;
  Contact _contact;
  int status = 0;

  Future<bool> submitForm(BuildContext context2) async {
    bool _error = false;
    setState(() {
      enabled = !enabled;
    });
    if (_amountController.text.length == 0) {
      setState(() {
        amountPlaceholder = 'من فضلك، اختر مبلغ مناسب';
        _error = true;
      });
    } else
      amountPlaceholder = "حد اقصى 99 جنيه";
    if (_contact == null) {
      setState(() {
        contactPlaceholder = 'من فضلك، اختر شخص محدد';
      });
    } else
      contactPlaceholder = 'حدد الشخص اللي هتستلف منه';

    if (_error == true) {
      setState(() {
        enabled = false;
      });
      return false;
    }
    NameModel name =
        Provider.of<ProfilesProvider>(context, listen: false).profile.name;
    Map<String, String> body = {
      "phone": getNumber(_contact.phoneNumber.number),
      "name": '${name.first} ${name.last}',
      "amount": _amountController.text
    };
    ServerResponse result =
        await Provider.of<TransactionsProvider>(context, listen: false)
            .makeARequest(body);
    if (result.status)
      Scaffold.of(context2).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text("تم اتمام طلبك بنجاح",
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.white))));
    else if (result.message.contains("عذرا،"))
      Scaffold.of(context2).showSnackBar(SnackBar(
          content: Text(result.message,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.white))));
    else
      Scaffold.of(context2).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(result.message,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.white))));
    return result.status;
  }

  @override
  void dispose() {
    super.dispose();
    _amountController.dispose();
  }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: SingleChildScrollView(
        child: Container(
          height: height - height * 0.2,
          child: Column(
            children: <Widget>[
              SizedBox(height: 15),
              FormGeneral(
                title: "هتستلف من:",
                placeholder: contactPlaceholder,
                widget: GestureDetector(
                  child: Column(
                    children: <Widget>[
                      Divider(height: 1),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        color: Colors.white,
                        width: double.infinity,
                        height: height * 0.06,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.person,
                                color: _contact != null
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey),
                            SizedBox(width: 20),
                            _contact == null
                                ? Text("اختار شخص من قائمتك ...",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(color: Colors.grey))
                                : Expanded(
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: Text(
                                          getName(_contact.fullName),
                                          style: TextStyle(
                                              fontFamily: "Cairo",
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w700),
                                        )),
                                        Expanded(
                                            child: Text(
                                          getNumberViewString(
                                              _contact.phoneNumber.number),
                                          textDirection: TextDirection.ltr,
                                          textAlign: TextAlign.end,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              .copyWith(
                                                  fontFamily: "Product Sans",
                                                  color: Colors.grey),
                                        )),
                                      ],
                                    ),
                                  )
                          ],
                        ),
                      ),
                      Divider(height: 1),
                    ],
                  ),
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    Contact contact = await _contactPicker
                        .selectContact()
                        .catchError((err) => throw err)
                        .then((contact) {
                      return contact;
                    });
                    if (contact != null) {
                      setState(() {
                        _contact = contact;
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 25),
              FormGeneral(
                title: "حدد المبلغ:",
                widget: Column(children: <Widget>[
                  Divider(height: 1),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  onTap: () {},
                                  keyboardType: TextInputType.number,
                                  controller: _amountController,
                                  onChanged: (_) {
                                    setState(() {
                                      word = true;
                                    });
                                  },
                                  scrollPadding: EdgeInsets.all(0),
                                  inputFormatters: [
                                    BlacklistingTextInputFormatter(
                                        RegExp('[\\-|\\ ]')),
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(2)
                                  ],
                                  strutStyle:
                                      StrutStyle(forceStrutHeight: true),
                                  cursorColor: Theme.of(context).primaryColor,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          fontFamily: "Product Sans",
                                          fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.money_off,
                                    ),
                                    focusedBorder: InputBorder.none,
                                    hintText: "اختار الرقم المناسب لك ...",
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              word && _amountController.text != ""
                                  ? Expanded(
                                      child: Text(
                                      "جنيه مصري",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(color: Colors.grey),
                                    ))
                                  : Container(),
                            ],
                          ),
                        ),
                        Divider(height: 1),
                      ],
                    ),
                  ),
                  Divider(height: 1),
                ]),
                placeholder: amountPlaceholder,
              ),
              Expanded(
                  child: Column(
                children: <Widget>[
                  Spacer(flex: 2),
                  Builder(
                    builder: (context2) => LoadingButton(
                        label: "استلف فلوس",
                        handleTap: () async {
                          bool status = await submitForm(context2);
                          if (status) {
                            _amountController.clear();
                            setState(() {
                              _contact = null;
                              word = false;
                            });
                          }
                        }),
                  ),
                  Spacer(),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

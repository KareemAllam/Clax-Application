// Dart & Other Packages
import 'package:clax/screens/Rides/widgets/offerCard.dart';
import 'package:clax/widgets/null.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Providers
import 'package:clax/providers/Payment.dart';
// Models
import 'package:clax/models/Error.dart';
import 'package:clax/models/Offer.dart';
// Drawer
import 'package:clax/screens/Drawer.dart';

class FreeRides extends StatefulWidget {
  static const routeName = '/freeRides';

  @override
  _FreeRidesState createState() => _FreeRidesState();
}

class _FreeRidesState extends State<FreeRides> {
  TextEditingController promoCodeController = TextEditingController();
  bool tapped = false;
  bool loading = false;
  List<Offer> offers;
  @override
  void didChangeDependencies() {
    offers = Provider.of<PaymentProvider>(context).offers;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    promoCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: <Widget>[
          Builder(
              builder: (context) => IconButton(
                  icon: loading
                      ? SpinKitCircle(color: Colors.white, size: 24)
                      : Icon(Icons.refresh),
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    ServerResponse result = await Provider.of<PaymentProvider>(
                            context,
                            listen: false)
                        .fetchOffers();
                    if (!result.status) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            result.message,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      );
                    }
                    setState(() {
                      loading = false;
                    });
                  }))
        ],
        title: Text('الرحلات المجانية',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white)),
      ),
      drawer: MainDrawer(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Theme.of(context).scaffoldBackgroundColor,
            width: double.infinity,
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Builder(
                  builder: (context) => TextField(
                    controller: promoCodeController,
                    textInputAction: TextInputAction.done,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]"))
                    ],
                    maxLength: 6,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      filled: true,
                      counterText: '',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[350]),
                          borderRadius: BorderRadius.circular(30)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[350]),
                          borderRadius: BorderRadius.circular(30)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(30)),
                      fillColor: Colors.white,
                      suffix: GestureDetector(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text('يلا كلاكس',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                      color: Theme.of(context).primaryColor)),
                        ),
                        onTap: tapped
                            ? null
                            : () async {
                                setState(() {
                                  tapped = true;
                                });
                                FocusScope.of(context).unfocus();
                                if (promoCodeController.text.length < 6) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                      "تأكد من رقم البروموكود و حاول مره اخرى",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(color: Colors.white),
                                    ),
                                  ));
                                  return;
                                }
                                ServerResponse result =
                                    await Provider.of<PaymentProvider>(context,
                                            listen: false)
                                        .addOffer(promoCodeController.text);
                                if (!result.status) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      result.message,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(color: Colors.white),
                                    ),
                                  ));
                                }
                                promoCodeController.clear();
                                setState(() {
                                  tapped = true;
                                });
                              },
                      ),
                      prefixIcon: Icon(
                        Icons.card_giftcard,
                        size: 20,
                      ),
                      labelStyle: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: Colors.grey),
                      labelText: 'ادخل بروموكود جديد',
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "العروض الحالية",
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 16),
                      offers.length == 0
                          ? Center(
                              heightFactor: 6,
                              child: NullContent(things: "عروض"))
                          : ListView.builder(
                              itemCount: offers.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  OfferCard(offers[index]),
                            )
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

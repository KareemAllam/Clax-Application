// Dart & Other Packages
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Providers
import 'package:clax/providers/Payment.dart';
// Models
import 'package:clax/models/Card.dart';
import 'package:clax/models/CreditCard.dart';
// Components
import 'package:clax/screens/Payments/Components/PaymentExtendedAppBar.dart';
// Widgets
import 'package:clax/widgets/Cards.dart';
import 'package:clax/widgets/ExtendedAppBar.dart';
// Drawer
import 'package:clax/screens/Drawer.dart';

class PaymentScreen extends StatefulWidget {
  static const routeName = '/payments';
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  double balance = 0;
  bool refreshing = false;
  bool nic = false;
  List<CreditCardModel> cards = [];
  final menuCards = const [
    CardModel(
        title: 'تحويل فلوس',
        icon: Icons.import_export,
        description: 'ابعت و استقبل فلوس من اصحابك',
        screen: '/payment/transfer_money'),
    CardModel(
        title: 'سجل مدفوعاتك',
        icon: Icons.featured_play_list,
        description: 'اعرف تفاصيل اكتر عن مدفوعاتك',
        screen: "/payment/payment_history"),
  ];
  void add(card) {
    setState(() {
      cards.add(card);
    });
  }

  // Removing a Credit Card
  void updateCards(CreditCardModel card, bool add) {
    if (add)
      setState(() {
        cards.add(card);
      });
    else
      setState(() {
        cards = List<CreditCardModel>.from(
            cards.where((element) => element != card));
        refreshing = false;
        nic = false;
      });
  }

  Future updateData() async {
    setState(() {
      refreshing = true;
    });
    bool result =
        await Provider.of<PaymentProvider>(context, listen: false).fetchData();
    if (result)
      setState(() {
        refreshing = false;
        nic = false;
      });
    else
      setState(() {
        refreshing = false;
        nic = true;
      });
  }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          actions: <Widget>[
            refreshing
                ? Container(
                    margin: EdgeInsets.only(left: 10),
                    child: SpinKitChasingDots(size: 20, color: Colors.white))
                : Builder(
                    builder: (context) => IconButton(
                        icon: Icon(Icons.refresh, color: Colors.white),
                        onPressed: updateData),
                  )
          ],
          elevation: 0.0,
          title: Text(
            'المدفوعات',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(height * 0.2),
            child: ExtendedAppbar(child: PaymentAppBarBottom()),
          ),
        ),
        body: RefreshIndicator(
            displacement: 10,
            child: ListView.builder(
              itemCount: menuCards.length,
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              controller: new ScrollController(),
              itemBuilder: (context, index) =>
                  Cards.navigationCard(context, card: menuCards[index]),
            ),
            onRefresh: updateData));
  }
}

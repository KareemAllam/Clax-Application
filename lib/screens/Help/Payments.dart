// Flutter's Material Components
import 'package:flutter/material.dart';
// Screens
import 'package:clax/screens/Help/CreditCard.dart';
import 'package:clax/screens/Help/Cancellations.dart';
import 'package:clax/screens/Help/PaymentOptions.dart';
import 'package:clax/screens/Help/UpfrontPricing.dart';
import 'package:clax/screens/Help/PromoCodes.dart';
// Widgets
import 'package:clax/widgets/appBar.dart';
import 'package:clax/widgets/listTile.dart';

class Payments extends StatelessWidget {
  static const routeName = '/Payments';
  final List<Map<String, dynamic>> menu = [
    {
      "title": "طلب المساعدة بشأن البطاقة الائتمانية",
      "icon": Icons.live_help,
      "route": CreditCard.routeName
    },
    {
      "title": "الإلغاء",
      "icon": Icons.cancel,
      "route": Cancellations.routeName
    },
    {
      "title": "التعرفة الأولية",
      "icon": Icons.indeterminate_check_box,
      "route": UpFrontPricing.routeName
    },
    {
      "title": "خيارات الدفع",
      "icon": Icons.credit_card,
      "route": PayOptions.routeName
    },
    {
      "title": "البروموكود",
      "icon": Icons.card_giftcard,
      "route": PromoCodes.routeName
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'المدفوعات والإيصالات'),
      body: ListView.builder(
        itemBuilder: (context, index) => buildListTile(
          context,
          menu[index]["title"],
          menu[index]['icon'],
          () => Navigator.of(context).pushNamed(menu[index]["route"]),
        ),
        itemCount: menu.length,
        controller: ScrollController(),
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      ),
    );
  }
}

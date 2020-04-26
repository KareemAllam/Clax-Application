// Flutter's Material Components
import 'package:flutter/material.dart';
// Screens
import 'package:clax/screens/Home/creditCard.dart';
import 'package:clax/screens/Home/cancellations.dart';
import 'package:clax/screens/Home/payOptions.dart';
import 'package:clax/screens/Home/upfrontPricing.dart';
import 'package:clax/screens/Home/wallet.dart';
import 'package:clax/screens/Home/promoCodes.dart';
// Widgets
import 'package:clax/widgets/appBar.dart';
import 'package:clax/widgets/listTile.dart';

class Payments extends StatelessWidget {
  static const routeName = '/Payments';
  final List<Map<String, dynamic>> menu = [
    {
      "title": "طلب المساعدة بشأن البطاقة الائتمانية",
      "route": CreditCard.routeName
    },
    {"title": "الإلغاء", "route": Cancellations.routeName},
    {"title": "التعرفة الأولية", "route": UpFrontPricing.routeName},
    {"title": "محفظة كلاكس", "route": Wallet.routeName},
    {"title": "خيارات الدفع", "route": PayOptions.routeName},
    {"title": "البروموكود", "route": PromoCodes.routeName},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'المدفوعات والإيصالات'),
      body: ListView.builder(
        itemBuilder: (context, index) => buildListTile1(
          context,
          menu[index]["title"],
          () => Navigator.of(context).pushNamed(menu[index]["route"]),
        ),
        itemCount: menu.length,
        controller: ScrollController(),
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      ),
    );
  }
}

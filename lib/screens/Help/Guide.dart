// Flutter's Material Components
import 'package:flutter/material.dart';
// Widgets
import 'package:clax/widgets/Cards.dart';

class Guide extends StatelessWidget {
  static const routeName = '/Guide';
  final List<Map<String, dynamic>> menu = [
    {
      "title": "مكآفات كلاكس",
      "icon": Icons.card_giftcard,
      // "route": rewards.routeName
    },
    {
      "title": "عن كلاكس",
      "icon": Icons.location_city,
      // "route": about.routeName
    },
    {
      "title": "كيف تتعامل مع السائق",
      "icon": Icons.person,
      // "route": driver.routeName
    },
    {
      "title": "اخفاء المكالمات",
      "icon": Icons.call,
      // "route": hideCalls.routeName
    },
    {
      "title": "خيارات الدفع",
      "icon": Icons.payment,
      // "route": payOptions.routeName
    },
    {
      "title": "كيفية إدارة حسابي",
      "icon": Icons.help_outline,
      // "route": accManagement.routeName
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('البطاقة الائتمانية',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white)),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => Cards.listTile(
          context,
          title: menu[index]["title"],
          icon: menu[index]["icon"],
          tapHandler: () =>
              Navigator.of(context).pushNamed(menu[index]["route"]),
        ),
        itemCount: menu.length,
        controller: ScrollController(),
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      ),
    );
  }
}

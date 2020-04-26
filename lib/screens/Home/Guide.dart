// Flutter's Material Components
import 'package:flutter/material.dart';
// Widgets
import 'package:clax/widgets/appBar.dart';
import 'package:clax/widgets/listTile.dart';

class Guide extends StatelessWidget {
  static const routeName = '/Guide';
  final List<Map<String, dynamic>> menu = [
    {
      "title": "مكآفات كلاكس"
      // "route": rewards.routeName
    },
    {
      "title": "عن كلاكس"
      // "route": about.routeName
    },
    {
      "title": "كيف تتعامل مع السائق"
      // "route": driver.routeName
    },
    {
      "title": "اخفاء المكالمات"
      // "route": hideCalls.routeName
    },
    {
      "title": "خيارات الدفع"
      // "route": payOptions.routeName
    },
    {
      "title": "كيفية إدارة حسابي"
      // "route": accManagement.routeName
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'الإرشادات'),
      body: ListView.builder(
        itemBuilder: (context, index) => buildListTile(
          context,
          menu[index]["title"],
          menu[index]["icon"],
          () => Navigator.of(context).pushNamed(menu[index]["route"]),
        ),
        itemCount: menu.length,
        controller: ScrollController(),
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      ),
    );
  }
}

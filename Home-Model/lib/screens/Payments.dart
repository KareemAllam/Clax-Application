import 'package:clax/screens/promoCodes.dart';
import 'package:clax/widgets/appBar.dart';
import 'package:clax/widgets/listTile.dart';
import 'package:flutter/material.dart';
import 'creditCard.dart';
import 'cancellations.dart';
import 'payOptions.dart';
import 'upfrontPricing.dart';
import 'wallet.dart';

class Payments extends StatelessWidget {
  static const routeName = '/Payments';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'المدفوعات والإيصالات'),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          buildListTile1(
            context,
            'طلب المساعدة بشأن البطاقة الائتمانية',
            () {
              Navigator.of(context).pushNamed(CreditCard.routeName);
            },
          ),
          buildListTile1(
            context,
            ' الإلغاء',
            () {
              Navigator.of(context).pushNamed(Cancellations.routeName);
            },
          ),
          buildListTile1(
            context,
            ' التعرفة الأولية',
            () {
              Navigator.of(context).pushNamed(UpFrontPricing.routeName);
            },
          ),
          buildListTile1(
            context,
            'محفظة كلاكس',
            () {
              Navigator.of(context).pushNamed(Wallet.routeName);
            },
          ),
          buildListTile1(
            context,
            ' خيارات الدفع',
            () {
              Navigator.of(context).pushNamed(PayOptions.routeName);
            },
          ),
          buildListTile1(
            context,
            ' البروموكود',
            () {
              Navigator.of(context).pushNamed(PromoCodes.routeName);
            },
          ),
        ],
      ),
    );
  }
}

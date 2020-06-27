import 'package:flutter/material.dart';
import '../widgets/ExtendedAppBar.dart';
import '../widgets/Card_NavigationElement.dart';
import '../models/card.dart';

const menuCards = const [
  Cardd(
      title: 'اكتب شكوى جديدة',
      icon: Icons.textsms,
      description: 'اكتب شكوى عن مشكلة حصلت',
      screen: '/payment/complaints/writeAComplain'),
  Cardd(
      title: 'راجع الشكاوى السابقة',
      icon: Icons.history,
      description: 'اعرف تفاصيل اكتر عن الشكاوى السابقة',
      screen: "/payment/complaints/complaintsHistory"),
  Cardd(
      title: 'اتصل بينا',
      icon: Icons.phone,
      description: 'تواصل معنا مباشراً',
      screen: "tel://07775000")
];

class Complaints extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return new Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'الشكاوى',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(height * 0.2),
          child: ExtendedAppbar(
            child: new ComplaintsAppBarVisuals(width: width, height: height),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: menuCards.length,
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        controller: new ScrollController(),
        itemBuilder: (context, index) => NavigationCard(card: menuCards[index]),
      ),
    );
  }
}

class ComplaintsAppBarVisuals extends StatelessWidget {
  const ComplaintsAppBarVisuals({
    Key key,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Align(
              child: Text(
                "اكتب شكوى جديدة/ \n راجع الشكاوي السابقة",
                strutStyle: StrutStyle(leading: 1.5, forceStrutHeight: true),
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    fontFamily: 'Cairo',
                    color: Theme.of(context).backgroundColor),
              ),
              alignment: Alignment(1, -0.4),
            ),
            flex: 2,
          ),
          Expanded(
              child: Align(
                child: Icon(
                  Icons.feedback,
                  color: Theme.of(context).accentColor,
                  size: height * 0.14,
                ),
                alignment: Alignment(0, -0.5),
              ),
              flex: 1)
        ],
      ),
    );
  }
}

// Flutter's Material Components
import 'package:flutter/material.dart';

class CreditCardType extends StatelessWidget {
  final Widget selectedWidget;
  CreditCardType({this.selectedWidget});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Container(
              height: height * 0.2,
              color: Colors.white,
              alignment: Alignment.center,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: selectedWidget,
              )),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: height * 0.185,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black26)),
              alignment: Alignment.center,
            ),
          )
        ],
      ),
    );
  }
}

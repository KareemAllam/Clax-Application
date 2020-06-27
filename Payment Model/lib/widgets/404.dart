import 'package:flutter/material.dart';

class FourOFour extends StatelessWidget {
  final Function press;
  FourOFour({this.press});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 0.5, color: Colors.grey)],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          child: Text('عذرًا، لقد تعذر الوصول للخادم'),
        ),
        SizedBox(height: 20),
        RaisedButton(
          shape: StadiumBorder(),
          elevation: 1,
          highlightElevation: 1,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          child: Text('إعادة المحاولة',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              )),
          onPressed: () {
            press();
          },
        )
      ],
    );
  }
}

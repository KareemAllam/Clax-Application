import 'package:flutter/material.dart';

class Action_btn extends StatelessWidget {
 final String text ;
  final IconData icon_btn;
  Action_btn(this.icon_btn,this.text);


  @override
  Widget build(BuildContext context) {
    return
      Container(
     child: Row(
      children: <Widget>[

        IconButton(icon: Icon(icon_btn,color: Theme.of(context).primaryColor,), onPressed: null),


        Text('${text}', style: Theme.of(context).textTheme.title)
      ],
    ));

  }

}

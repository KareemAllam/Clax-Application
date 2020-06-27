import 'package:flutter/material.dart';

class Okbtn extends StatelessWidget {
 final String name_page ;
  final String name_btn;
  Okbtn(this.name_btn,this.name_page);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
        child: FlatButton(
          child: Text('${name_btn}'),
          textColor: Colors.white,

          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(

            borderRadius: new BorderRadius.circular(18.0),
            side: BorderSide(color: Theme.of(context).primaryColor),


          ),
          padding: EdgeInsets.all(8.0),
          onPressed: (){
            Navigator.pushNamed(context, '${name_page}');
          },



        ),
      );

  }

}

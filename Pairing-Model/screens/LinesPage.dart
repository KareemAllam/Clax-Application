import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paring/widgets/Pair_btn.dart';
import 'package:paring/widgets/action_btn.dart';
import 'package:paring/widgets/ListView.dart';
import 'package:paring/widgets/ListViewline.dart';

class LinesPage extends StatefulWidget {
  @override
  _LinesPageState createState() => _LinesPageState();
}

class _LinesPageState extends State<LinesPage> {
  final lines = [
    'زفتي ',
    'كفر الزيات ',
    'سمنود',
  ];
  final fees = [
    '10 ',
    '15  ',
    '7',
  ];

  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(" اختر محطتك"),
        ),
        body: SafeArea(
            child:

            Column(
          children: <Widget>[
            Container(
                child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.add_box,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: null),
                Text("رحلاتك",style: Theme.of(context).textTheme.title)
              ],
            )),
     /// DropdownButton(items: null , onChanged: null ,icon: icon(Icons.star)),

      Expanded(child:Column(children: <Widget>[
          ListTile(title: Text("الأجرة",style: Theme.of(context).textTheme.title)
        ,leading: Text("الخطوط",style: Theme.of(context).textTheme.title,),),

        Expanded(child: DataListView(),)
      ],)),

            Okbtn("تأكید", "stationpage")
          ],
        )

        ));
  }
/*
          child: <Widget>[

              Container(child: Row(
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: null,
                    child: Icon(Icons.add,color: Colors.white, ),
                    mini: true,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  Text("رحلاتك الثابتة",style: Theme.of(context).textTheme.title)
                ],
              ),

              ),


    ListView.builder(
    itemCount: lines.length,
    itemBuilder: (context, index) {
    return ListTile(
    title: Text(lines[index]),
    );
    },
    ),



            ],
        ),

        appBar: AppBar(title: Text("اختر اتجاھك",),





    ));

  }}*/
}

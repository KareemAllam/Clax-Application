import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paring/widgets/Pair_btn.dart';
//import 'package:flutter_app_test4/widgets/action_btn.dart';

class StationPage extends StatefulWidget {
  @override
  _StationPageState createState() => _StationPageState();
}

class _StationPageState extends State<StationPage> {
  final lines = [
    'كفرالزيات',
    'برما',
    'شبرا',
    'محلة مرحوم',
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
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(8.0),
                  children: lines
                      .map((data) => RadioListTile(
                            title: Text("${data}"),
                            // groupValue: _currentIndex,
                            value: data,
                            onChanged: (val) {
                              setState(() {
                                _currentIndex = val;
                              });
                            },
                          ))
                      .toList(),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    icon: Container(
                      margin: EdgeInsets.only(left: 20, top: 5),
                      width: 10,
                      height: 10,
                      child: Icon(
                        Icons.create,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    hintText: " بروموكود..",
                    contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                  ),
                ),
              ),
              Okbtn("يلا كلاكس", "detailstrip")
            ])));
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

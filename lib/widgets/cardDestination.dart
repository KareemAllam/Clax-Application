import 'package:flutter/material.dart';

class DestinationCard extends StatelessWidget {
  final String fromTo;
  final String cost;
  DestinationCard(this.fromTo, this.cost);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
        child: Container(
            decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
            child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right: new BorderSide(
                              width: 1.0, color: Colors.white24))),
                  child: Icon(Icons.directions_bus,
                      color: Theme.of(context).textTheme.subtitle1.color),
                ),
                title: Text(
                  fromTo,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

//        subtitle: Row(
//          children: <Widget>[
//            Icon(Icons.linear_scale, color: Colors.yellowAccent),
//            Text(" Intermediate", style: TextStyle(color: Colors.white))
//          ],
//        ),
                trailing:
                    //Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)) ,
                    Text(
                  cost.toString(),
                  style: Theme.of(context).textTheme.subtitle1,
                ))));
  }
}

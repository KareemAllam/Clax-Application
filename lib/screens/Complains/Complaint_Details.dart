// Dart & Other Packages
import 'package:intl/intl.dart' as intl;
// Flutter's Material Components
import 'package:flutter/material.dart';
// Models
import 'package:clax/models/Complain.dart';
import 'package:clax/models/Trip.dart';

class ComplainDetails extends StatefulWidget {
  static const routeName = '/complaints/complaintsHistory/complaintDetails';
  @override
  _ComplainDetailsState createState() => _ComplainDetailsState();
}

class _ComplainDetailsState extends State<ComplainDetails> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    Map<String, dynamic> args =
        Map<String, dynamic>.from(ModalRoute.of(context).settings.arguments);
    ComplainModel complain = args['complain'];
    Trip trip = args['trip'];
    Widget widget;
    if (complain.status != "pending")
      widget = Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          // height: height * 0.1,
          width: double.infinity,
          color: Colors.green,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.check_circle_outline,
                  color: Theme.of(context).accentColor),
              SizedBox(width: 15),
              Text(
                complain.response ?? "404",
                softWrap: true,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: Colors.white),
              ),
            ],
          ));
    else
      widget = Container(
          height: height * 0.1,
          width: double.infinity,
          color: Colors.red,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.highlight_off, color: Colors.white),
                SizedBox(width: 15),
                Flexible(
                  child: Text(
                    "لم يتم حل المشكلة بعد",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(color: Colors.white),
                  ),
                )
              ]));

    return Scaffold(
      appBar: AppBar(
          title: Text('مراجعة الشكاوى',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white))),
      body: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 400),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(spreadRadius: 0.1, color: Colors.black54)
                ],
                // borderRadius: BorderRadius.only(
                //     bottomLeft: Radius.circular(20),
                //     bottomRight: Radius.circular(20))
              ),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: <
                      Widget>[
                Expanded(
                  flex: 4,
                  child:
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Row(children: <Widget>[
                      ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 30),
                          child: Icon(Icons.error_outline,
                              color: Theme.of(context).primaryColor)),
                      SizedBox(width: 10),
                      Text('${complain.subject}',
                          strutStyle: StrutStyle(forceStrutHeight: true),
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                              color: Color(0xff212121),
                              fontWeight: FontWeight.w700))
                    ]),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 30),
                          child: Icon(Icons.calendar_today,
                              color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(width: 10),
                        Text(
                            intl.DateFormat('EEE M/d h:mm a')
                                .format(complain.date),
                            strutStyle: StrutStyle(forceStrutHeight: true),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.ltr,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(fontFamily: "Product Sans")),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(children: <Widget>[
                      if (trip != null)
                        Row(children: <Widget>[
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 30),
                            child: Icon(Icons.confirmation_number,
                                color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(width: 10),
                          Text(trip.price.toString() ?? 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(fontFamily: "Product Sans")),
                          Text(" جنية مصرى",
                              strutStyle: StrutStyle(forceStrutHeight: true),
                              style: Theme.of(context).textTheme.subtitle2)
                        ]),
                      if (trip != null) Spacer(),
                      Row(children: <Widget>[
                        Icon(Icons.report_problem,
                            color: Theme.of(context).primaryColor),
                        SizedBox(width: 5),
                        Text(
                          complain.code.toString().substring(0, 5),
                          strutStyle: StrutStyle(forceStrutHeight: true),
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontFamily: "Product Sans", color: Colors.grey),
                        )
                      ]),
                      Spacer(),
                    ]),
                  ]),
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                      // decoration: BoxDecoration(
                      //   border: Border(
                      //     right: BorderSide(
                      //       color: Colors.black26,
                      //     ),
                      //   ),
                      // ),
                      child: CircleAvatar(
                          maxRadius: 45.0,
                          backgroundColor: Colors.transparent,
                          child: FadeInImage(
                              placeholder: AssetImage('assets/images/404.png'),
                              image: AssetImage('assets/images/404.png'))),
                    )
                    // child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.end,
                    //     mainAxisSize: MainAxisSize.min,
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       CircleAvatar(
                    //         maxRadius: 45.0,
                    //         backgroundColor: Colors.transparent,
                    //         child: FadeInImage(
                    //             placeholder: AssetImage('assets/images/logo.png'),
                    //             image: NetworkImage(complain.image)),
                    //       ),
                    // Text(complain.trip.driver.name == ""
                    //     ? "غير معلوم"
                    //     : complain.trip.driver.name)
                    // ]),
                    ),
              ]),
            ),
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(spreadRadius: 0.1, color: Colors.black54)
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              // height: height * 0.5,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              width: double.infinity,
              child: Text(
                complain.text,
                textAlign: TextAlign.right,
              )),
          Spacer(),
          widget
        ],
      ),
    );
  }
}

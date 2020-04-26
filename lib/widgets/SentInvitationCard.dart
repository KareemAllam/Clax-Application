import '../models/familyrequests.dart';
import 'package:flutter/material.dart';

class SentInvitationCard extends StatelessWidget {
  final FamilyRequest member;
  final Function cancel;
  SentInvitationCard({this.member, this.cancel});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(color: Colors.black12, width: 0),
              bottom: BorderSide(color: Colors.black12, width: 0),
            )),
        child: Row(
          children: <Widget>[
            Icon(Icons.arrow_back, color: Colors.black87),
            SizedBox(width: 20),
            // Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  member.name,
                  strutStyle: StrutStyle(forceStrutHeight: true),
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: 18),
                ),
              ],
            ),
            // Spacer(flex: 1),
            SizedBox(width: 10),
            Text(
              "-   " + member.phone,
              strutStyle: StrutStyle(forceStrutHeight: true),
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(fontSize: 14, color: Colors.black26),
            ),
            Spacer(),
            Container(
              width: 30,
              child: IconButton(
                  tooltip: "امسح فرد",
                  icon: Icon(
                    Icons.delete,
                    color: Colors.black45,
                  ),
                  onPressed: () {
                    cancel(member.sId);
                    print("request canceld");
                  }),
            ),
          ],
        ));
  }
}

import 'package:clax/models/Error.dart';
import 'package:clax/models/Familymembers.dart';
import 'package:clax/providers/Family.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SentInvitationCard extends StatelessWidget {
  final FamilyMember member;
  SentInvitationCard({this.member});
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
                  '${member.name.first} ${member.name.last}',
                  strutStyle: StrutStyle(forceStrutHeight: true),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Theme.of(context).primaryColor),
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
                onPressed: () async {
                  ServerResponse response =
                      await Provider.of<FamilyProvider>(context, listen: false)
                          .cancelSentRequest(member.phone);
                  if (response.status)
                    print("request canceld");
                  else
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(response.message),
                      ),
                    );
                },
              ),
            ),
          ],
        ));
  }
}

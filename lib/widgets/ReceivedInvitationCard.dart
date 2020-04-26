import 'package:clax/models/familyrequests.dart';
import 'package:flutter/material.dart';

class MemberInvitationCard extends StatelessWidget {
  final FamilyRequest invitation;
  final Function accept;
  final Function deny;
  const MemberInvitationCard({Key key, this.invitation, this.accept, this.deny})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.black12, width: 0),
                  bottom: BorderSide(color: Colors.black12, width: 0),
                )),
            child: Row(
              children: <Widget>[
                Icon(Icons.arrow_forward, color: Colors.black87),
                SizedBox(width: 20),
                // Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      invitation.name,
                      strutStyle: StrutStyle(forceStrutHeight: true),
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(width: 10),

                Text(
                  "-   " + invitation.phone,
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
                      padding: EdgeInsets.all(0),
                      alignment: Alignment.centerRight,
                      tooltip: "قبول الدعوة",
                      icon: Icon(
                        Icons.add_circle,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        accept(invitation.sId);
                        print("accpeted");
                      }),
                ),
                Container(
                  width: 30,
                  child: IconButton(
                      // padding: EdgeInsets.all(0),
                      alignment: Alignment.centerLeft,
                      tooltip: "رفض الدعوة",
                      icon: Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        deny(invitation.sId);
                        print("denied");
                      }),
                )
              ],
            )),
      ],
    );
  }
}

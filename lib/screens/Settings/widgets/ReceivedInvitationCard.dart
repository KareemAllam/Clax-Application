import 'package:clax/models/Error.dart';
import 'package:clax/models/Familymembers.dart';
import 'package:clax/providers/Family.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MemberInvitationCard extends StatelessWidget {
  final FamilyMember invitation;
  const MemberInvitationCard({Key key, this.invitation}) : super(key: key);

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
                      '${invitation.name.first} ${invitation.name.last}',
                      strutStyle: StrutStyle(forceStrutHeight: true),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Theme.of(context).primaryColor),
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
                      onPressed: () async {
                        ServerResponse accepted =
                            await Provider.of<FamilyProvider>(context,
                                    listen: false)
                                .acceptRequest(invitation.id);
                        if (accepted.status)
                          print("accpeted");
                        else
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text(accepted.message)));
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
                      onPressed: () async {
                        ServerResponse rejected =
                            await Provider.of<FamilyProvider>(context,
                                    listen: false)
                                .rejectRequest(invitation.id);
                        if (rejected.status)
                          print("denied");
                        else
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text(rejected.message)));
                      }),
                )
              ],
            )),
      ],
    );
  }
}

import 'package:clax/widgets/SentInvitationCard.dart';
import 'package:flutter/material.dart';
import 'package:clax/widgets/null.dart';

class SentInvitations extends StatelessWidget {
  final List invitations;
  final Function cancel;
  SentInvitations({this.invitations, this.cancel});
  List<Widget> getListFiles() {
    List<Widget> invitationsWidgets = invitations
        .map((invitation) => SentInvitationCard(
              member: invitation,
              cancel: cancel,
            ))
        .toList();

    return invitationsWidgets;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text(
                "دعوات اضافة",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 20),
              )),
          SizedBox(height: 10),
          invitations.length > 0
              ? {
                  ...getListFiles(),
                  ...invitations.map((invitation) => SentInvitationCard(
                        member: invitation,
                        cancel: cancel,
                      )),
                }
              : Container(
                  alignment: Alignment.center,
                  height: height - height * 0.4,
                  child: NullContent(things: "طلبات")),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}

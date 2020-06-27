import '../../widgets/null.dart';
import 'package:flutter/material.dart';
import '../../widgets/ReceivedInvitationCard.dart';

class FamilyMembersInvitations extends StatelessWidget {
  final List invitations;
  final Function accept;
  final Function deny;
  FamilyMembersInvitations({this.invitations, this.accept, this.deny});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
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
                    ...invitations.map((invitation) => MemberInvitationCard(
                          invitation: invitation,
                          accept: accept,
                          deny: deny,
                        )),
                  }
                : Container(
                    alignment: Alignment.center,
                    height: height - height * 0.4,
                    child: NullContent(things: "دعوات")),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

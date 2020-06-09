// Dart & Other Pacakges
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Models
import 'package:clax/models/Familymembers.dart';
// Providers
import 'package:clax/providers/Family.dart';

// Widgets
import 'package:clax/widgets/null.dart';
import 'package:clax/screens/Settings/widgets/ReceivedInvitationCard.dart';

class FamilyMembersInvitations extends StatefulWidget {
  @override
  _FamilyMembersInvitationsState createState() =>
      _FamilyMembersInvitationsState();
}

class _FamilyMembersInvitationsState extends State<FamilyMembersInvitations> {
  List<FamilyMember> receivedInvitations;
  void didChangeDependencies() {
    super.didChangeDependencies();
    receivedInvitations =
        Provider.of<FamilyProvider>(context).familyRequestsReceived;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    bool empty = receivedInvitations.length == 0;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
                padding: EdgeInsets.only(right: 20, bottom: 5),
                child: Text(
                  "دعوات اضافة",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.w700, fontSize: 20),
                )),
            empty
                ? Container(
                    alignment: Alignment.center,
                    height: height - height * 0.4,
                    child: NullContent(things: "دعوات"))
                : ListView.builder(
                    itemCount: receivedInvitations.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => MemberInvitationCard(
                        invitation: receivedInvitations[index])),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

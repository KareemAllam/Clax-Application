// Dart & Other Pakcages
import 'package:provider/provider.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Models
import 'package:clax/models/Familymembers.dart';
// Widgets
import 'package:clax/widgets/null.dart';
import 'package:clax/screens/Settings/widgets/SentInvitationCard.dart';
// Providers
import 'package:clax/providers/Family.dart';

class SentInvitations extends StatefulWidget {
  @override
  _SentInvitationsState createState() => _SentInvitationsState();
}

class _SentInvitationsState extends State<SentInvitations> {
  List<FamilyMember> invitations;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    invitations = Provider.of<FamilyProvider>(context).familyRequestsSent;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    bool empty = invitations.length == 0;

    return SingleChildScrollView(
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
                  child: NullContent(things: "طلبات"))
              : ListView.builder(
                  itemCount: invitations.length,
                  controller: ScrollController(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => SentInvitationCard(
                        member: invitations[index],
                      )),
        ],
      ),
    );
  }
}

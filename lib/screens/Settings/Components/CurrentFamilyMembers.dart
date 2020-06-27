// Dart & Other Packages
import 'package:provider/provider.dart';
import 'package:contact_picker/contact_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Providers
import 'package:clax/providers/Family.dart';
// Models
import 'package:clax/models/Error.dart';
import 'package:clax/models/Familymembers.dart';
// Widgets
import 'package:clax/widgets/null.dart';
import 'package:clax/screens/Settings/widgets/MemberCard.dart';

class CurrentFamilyMembers extends StatefulWidget {
  @override
  _CurrentFamilyMembersState createState() => _CurrentFamilyMembersState();
}

class _CurrentFamilyMembersState extends State<CurrentFamilyMembers> {
  bool adding = false;
  List<FamilyMember> members = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    members = Provider.of<FamilyProvider>(context).familyMembers;
  }

  Widget addNewMember() {
    return GestureDetector(
      onTap: () async {
        Contact contact = await ContactPicker()
            .selectContact()
            .catchError((err) => throw err)
            .then((contact) {
          return contact;
        });

        if (contact != null) {
          setState(() {
            adding = true;
          });
          ServerResponse added =
              await Provider.of<FamilyProvider>(context, listen: false)
                  .makeRequest(contact);
          if (added.status)
            Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "تم بعت الطلب بنجاح",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.white),
                strutStyle: StrutStyle(forceStrutHeight: true),
              ),
            ));
          else
            Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                added.message,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.white),
                strutStyle: StrutStyle(forceStrutHeight: true),
              ),
            ));
          setState(() {
            adding = false;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(children: <Widget>[
          Icon(Icons.add_circle, color: Colors.green),
          SizedBox(width: 16),
          Text("اضف فرد جديدة لعائلتك",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(color: Colors.grey))
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool empty = members.length == 0;
    final double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20, top: 20),
              child: Text(
                "افراد العائلة",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 20),
              )),
          SizedBox(height: 10),
          adding
              ? SpinKitCircle(color: Theme.of(context).primaryColor, size: 30)
              : Column(
                  children: <Widget>[
                    empty
                        ? SizedBox()
                        : ListView.builder(
                            itemCount: members.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                MemberCard(member: members[index])),
                    addNewMember(),
                    empty
                        ? Container(
                            alignment: Alignment.center,
                            height: height - height * 0.5,
                            child: NullContent(things: "أفراد"),
                          )
                        : SizedBox()
                  ],
                )
        ],
      ),
    );
  }
}

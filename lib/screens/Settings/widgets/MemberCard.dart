import 'package:clax/models/Error.dart';
import 'package:clax/models/Familymembers.dart';
import 'package:clax/providers/Family.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import '../widgets/alertDialog.dart';

class MemberCard extends StatelessWidget {
  final FamilyMember member;
  MemberCard({this.member});
  @override
  Widget build(BuildContext context) {
    void areYouSure() {
      ThemeData theme = Theme.of(context);
      // set up the button
      Widget okButton = FlatButton(
        child: Text("لا",
            style:
                TextStyle(color: Colors.white60, fontWeight: FontWeight.bold)),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      // set charge the button
      Widget chargeNow = FlatButton(
          child: Text("نعم",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          onPressed: () async {
            ServerResponse result =
                await Provider.of<FamilyProvider>(context, listen: false)
                    .removeMember(member.id);
            if (result.status == false)
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text(result.message)));
            Navigator.pop(context);
          });

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        backgroundColor: Colors.transparent,
        title: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5))),
          padding: EdgeInsets.only(top: 20, right: 15, left: 15, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "هل انت متأكد انك تريد مسح ${member.name.first} ${member.name.last}؟",
                style: theme.textTheme.bodyText1
                    .copyWith(fontWeight: FontWeight.values[5]),
              ),
              SizedBox(height: 2),
              Text("لن تستطيع تتبع رحلات ${member.name.first} بعد حذفها.",
                  style: theme.textTheme.caption)
            ],
          ),
        ),
        buttonPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(0),
        titlePadding: EdgeInsets.all(0),
        contentPadding: EdgeInsets.all(0),
        content: Container(
            color: theme.primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                chargeNow,
                okButton,
              ],
            )),
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

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
            Icon(Icons.person, color: Colors.black87),
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
                  onPressed: areYouSure),
            ),
          ],
        ));
  }
}

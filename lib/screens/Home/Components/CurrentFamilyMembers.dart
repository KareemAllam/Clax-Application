// Dart & Other Packages
import 'package:contact_picker/contact_picker.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Models
import 'package:clax/models/familymembers.dart';
// Widgets
import 'package:clax/widgets/MemberCard.dart';
import 'package:clax/widgets/null.dart';

class CurrentFamilyMembers extends StatelessWidget {
  final List<FamilymemberModel> members;
  final Function remove;
  final Function addAMember;

  CurrentFamilyMembers({this.members, this.remove, this.addAMember});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        height: height - height * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      "افراد العائلة",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 20),
                    )),
                SizedBox(height: 10),
                members.length > 0
                    ? {
                        ...members.map((member) =>
                            MemberCard(member: member, remove: remove)),
                      }
                    : Container(
                        alignment: Alignment.center,
                        height: height - height * 0.4,
                        child: NullContent(things: "أفراد")),
                SizedBox(height: 5),
                Container(
                  child: Material(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: InkWell(
                        onTap: () {
                          print("pressed");
                        },
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: GestureDetector(
                            onTap: () async {
                              Contact contact = await ContactPicker()
                                  .selectContact()
                                  .catchError((err) => throw err)
                                  .then((contact) {
                                return contact;
                              });
                              if (contact != null) {
                                addAMember(contact).then((result) {
                                  if (result)
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text("تم بعت الطلب بنجاح"),
                                    ));
                                  else
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content:
                                          Text("عذرا، هذا الرقم غير موجود"),
                                    ));
                                });
                              }
                            },
                            child: Row(children: <Widget>[
                              Icon(Icons.add_circle, color: Colors.black54),
                              SizedBox(width: 20),
                              Text("اضف فرد جديدة لعائلتك")
                            ]),
                          ),
                        ),
                      )),
                ),
              ],
            ),
            Column(
                mainAxisSize: MainAxisSize.max,
                verticalDirection: VerticalDirection.up,
                children: [
                  RaisedButton(
                      shape: StadiumBorder(),
                      child: Text("إضافة فرد جديد لعائلتك",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                      color: Theme.of(context).primaryColor,
                      onPressed: () async {
                        Contact contact = await ContactPicker()
                            .selectContact()
                            .catchError((err) => throw err)
                            .then((contact) {
                          return contact;
                        });
                        if (contact != null) {
                          addAMember(contact).then((result) {
                            if (result)
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("تم ارسال الطلب بنجاح"),
                              ));
                            else
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("عذرا، هذا الرقم غير موجود"),
                              ));
                          });
                        }
                      })
                ])
          ],
        ),
      ),
    );
  }
}

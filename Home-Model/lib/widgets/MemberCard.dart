import 'package:clax/models/familymembers.dart';
import 'package:flutter/material.dart';
//import '../widgets/alertDialog.dart';

class MemberCard extends StatelessWidget {
  final Familymember member;
  final Function remove;
  MemberCard({this.member, this.remove});
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
            Icon(Icons.person, color: Colors.black87),
            SizedBox(width: 20),
            // Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  member.name,
                  strutStyle: StrutStyle(forceStrutHeight: true),
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: 18),
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
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        contentPadding: EdgeInsets.all(0),
                        backgroundColor: Colors.transparent,
                        titlePadding: EdgeInsets.all(0),
                        title: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Text(
                            "هل انت متأكد انك تريد مسح ${member.name}؟",
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ),
                        content: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      remove(member.sId);
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "نعم",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                right: BorderSide(
                                                    color: Colors.black12))),
                                        child: Text(
                                          "لا",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .copyWith(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                        )),
                                  ),
                                )
                              ],
                            )),
                      ),
                    );
                  }),
            ),
          ],
        ));
  }
}

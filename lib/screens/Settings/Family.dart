// Flutter's Material Components
import 'package:clax/providers/Family.dart';
import 'package:flutter/material.dart';
// Components
import 'package:clax/screens/Settings/Components/SentInvitations.dart';
import 'package:clax/screens/Settings/Components/ReceivedInvitations.dart';
import 'package:clax/screens/Settings/Components/CurrentFamilyMembers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class Members extends StatefulWidget {
  static const routeName = '/members';
  @override
  _MembersState createState() => _MembersState();
}

class _MembersState extends State<Members> {
  bool loading = false;
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                  icon: loading
                      ? SpinKitCircle(color: Colors.white, size: 25)
                      : Icon(Icons.refresh),
                  onPressed: loading
                      ? () {}
                      : () async {
                          setState(() {
                            loading = true;
                          });
                          await Provider.of<FamilyProvider>(context,
                                  listen: false)
                              .serverData();
                          setState(() {
                            loading = false;
                          });
                        })
            ],
            title: Text(
              "العائلة",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white),
            ),
            bottom: TabBar(
              tabs: [
                Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text("العائلة")),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text("الواردات"),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text("الصادرات"),
                )
              ],
            ),
          ),
          body: TabBarView(children: [
            CurrentFamilyMembers(),
            FamilyMembersInvitations(),
            SentInvitations()
          ])),
    );
  }
}

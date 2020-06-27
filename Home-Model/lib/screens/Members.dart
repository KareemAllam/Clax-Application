import 'dart:convert';
import 'package:clax/services/Backend.dart';
import 'package:clax/widgets/404.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:contact_picker/contact_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../screens/Components/ReceivedInvitations.dart';
import '../screens/Components/CurrentFamilyMembers.dart';
import '../models/familyrequests.dart';
import '../models/familymembers.dart';
import '../utils/phonenumber.dart';
import 'Components/SentInvitations.dart';

class Members extends StatefulWidget {
  static const routeName = '/members';

  @override
  _MembersState createState() => _MembersState();
}

class _MembersState extends State<Members> {
  bool loading = true;
  bool error = false;
  List<Familymember> members;
  List<FamilyRequest> sentInvitations;
  List<FamilyRequest> receivedInvitations;

  Future<bool> addAMember(Contact contact) async {
    String number = getNumberViewString(contact.phoneNumber.number);
    setState(() {});
    print(number);
    Response result = await Api.put('family/add', {"phone": number});
    if (result.statusCode == 200) {
      Response receivedRequestsRes = await Api.get('family/received-requests');

      List<FamilyRequest> receivedRequests = List<FamilyRequest>.from((json
          .decode(receivedRequestsRes.body)
          .map((trip) => FamilyRequest.fromJson(trip))).toList());

      setState(() {
        receivedInvitations = receivedRequests;
      });
      return true;
    } else
      return false;
  }

  void removeAMember(id) async {
    Response result = await Api.put('family/delete', {'_id': id.toString()});
    if (result.statusCode == 200)
      setState(() {
        members = members.where((element) => element.sId != id).toList();
      });
  }

  void acceptARequest(id) async {
    Response result =
        await Api.put('family/accept', {'acceptedId': id.toString()});
    if (result.statusCode == 200) {
      var acceptedmember =
          receivedInvitations.where((element) => element.sId == id).toList();
      setState(() {
        receivedInvitations =
            receivedInvitations.where((element) => element.sId != id).toList();
        members.add(Familymember(
            name: acceptedmember[0].name,
            phone: acceptedmember[0].phone,
            sId: acceptedmember[0].sId));
      });
    }
  }

  void denyARequest(id) async {
    Response result =
        await Api.put('family/accept', {'acceptedId': id.toString()});
    if (result.statusCode == 200)
      setState(() {
        receivedInvitations =
            receivedInvitations.where((element) => element.sId != id).toList();
      });
  }

  void cancelARequest(id) async {
    Response result =
        await Api.put('family/cancel', {'recipientId': id.toString()});
    if (result.statusCode == 200)
      setState(() {
        sentInvitations =
            sentInvitations.where((element) => element.sId != id).toList();
      });
  }

  void fetchdata() async {
    setState(() {
      loading = true;
    });
    Response membersRes = await Api.get('family/');
    Response sentRequestsRes = await Api.get('family/sent-requests');
    Response receivedRequestsRes = await Api.get('family/received-requests');

    List<Familymember> membersList = List<Familymember>.from((json
        .decode(membersRes.body)
        .map((trip) => Familymember.fromJson(trip))).toList());
    List<FamilyRequest> sentRequests = List<FamilyRequest>.from((json
        .decode(sentRequestsRes.body)
        .map((trip) => FamilyRequest.fromJson(trip))).toList());
    List<FamilyRequest> receivedRequests = List<FamilyRequest>.from((json
        .decode(receivedRequestsRes.body)
        .map((trip) => FamilyRequest.fromJson(trip))).toList());

    setState(() {
      loading = false;
      members = membersList;
      sentInvitations = sentRequests;
      receivedInvitations = receivedRequests;
    });
  }

  void initState() {
    super.initState();
    fetchdata();
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
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
            // title: _isSearching ? _buildSearchField() : _buildTitle(context),
            actions: [
              RotatedBox(
                  quarterTurns: 3,
                  child:
                      IconButton(icon: Icon(Icons.sync), onPressed: fetchdata))
            ],
          ),
          body: TabBarView(children: [
            loading
                ? Center(
                    child: SpinKitCircle(color: Theme.of(context).primaryColor))
                : error
                    ? FourOFour(press: fetchdata)
                    : CurrentFamilyMembers(
                        members: members,
                        remove: removeAMember,
                        addAMember: addAMember),
            loading
                ? Center(
                    child: SpinKitCircle(color: Theme.of(context).primaryColor))
                : FamilyMembersInvitations(
                    invitations: receivedInvitations,
                    accept: acceptARequest,
                    deny: denyARequest),
            loading
                ? Center(
                    child: SpinKitCircle(color: Theme.of(context).primaryColor))
                : SentInvitations(
                    invitations: sentInvitations, cancel: cancelARequest)
          ])),
    );
  }
}

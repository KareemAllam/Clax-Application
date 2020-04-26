// Dart & Other Packages
import 'dart:convert';
import 'package:http/http.dart';
import 'package:contact_picker/contact_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// Flutter's Material Components
import 'package:flutter/material.dart';
// Utils
import 'package:clax/utils/phonenumber.dart';
// Services
import 'package:clax/services/Backend.dart';
// Models
import 'package:clax/models/familyrequests.dart';
import 'package:clax/models/familymembers.dart';
// Components
import 'package:clax/screens/Home/Components/ReceivedInvitations.dart';
import 'package:clax/screens/Home/Components/CurrentFamilyMembers.dart';
import 'package:clax/screens/Home/Components/SentInvitations.dart';
// Widgets
import 'package:clax/widgets/404.dart';

class Members extends StatefulWidget {
  static const routeName = '/members';
  @override
  _MembersState createState() => _MembersState();
}

class _MembersState extends State<Members> {
  bool loading = true;
  bool error = false;
  List<FamilymemberModel> members;
  List<FamilyRequestModel> sentInvitations;
  List<FamilyRequestModel> receivedInvitations;

  Future<bool> addAMember(Contact contact) async {
    String number = getNumberViewString(contact.phoneNumber.number);
    setState(() {});
    print(number);
    Response result = await Api.put('family/add', {"phone": number});
    if (result.statusCode == 200) {
      Response receivedRequestsRes = await Api.get('family/received-requests');

      List<FamilyRequestModel> receivedRequests = List<FamilyRequestModel>.from(
          (json
              .decode(receivedRequestsRes.body)
              .map((trip) => FamilyRequestModel.fromJson(trip))).toList());

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
        members.add(FamilymemberModel(
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

    List<FamilymemberModel> membersList = List<FamilymemberModel>.from((json
        .decode(membersRes.body)
        .map((trip) => FamilymemberModel.fromJson(trip))).toList());
    List<FamilyRequestModel> sentRequests = List<FamilyRequestModel>.from((json
        .decode(sentRequestsRes.body)
        .map((trip) => FamilyRequestModel.fromJson(trip))).toList());
    List<FamilyRequestModel> receivedRequests = List<FamilyRequestModel>.from(
        (json
            .decode(receivedRequestsRes.body)
            .map((trip) => FamilyRequestModel.fromJson(trip))).toList());

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

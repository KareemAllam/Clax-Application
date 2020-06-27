// Dart & Other Pacakges
import 'dart:convert';
import 'package:clax/models/Error.dart';
import 'package:http/http.dart';
import 'package:contact_picker/contact_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Material Foundation
import 'package:flutter/foundation.dart';
// Models
import 'package:clax/models/Familymembers.dart';
import 'package:clax/models/Name.dart';
// Services
import 'package:clax/services/Backend.dart';
// Utils
import 'package:clax/utils/phonenumber.dart';

class FamilyProvider extends ChangeNotifier {
  List<FamilyMember> familyMembers;
  List<FamilyMember> familyRequestsSent;
  List<FamilyMember> familyRequestsReceived;

  FamilyProvider() {
    init();
  }
  init() {
    familyMembers = [];
    familyRequestsReceived = [];
    familyRequestsSent = [];
    cachedData();
    serverData();
  }

  /// fetch family data from Cache
  Future cachedData() async {
    List<FamilyMember> _;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    // Get Cached Received Requsts
    String _requestsReceived = _prefs.getString('requestsReceived');
    if (_requestsReceived != null) {
      List result = json.decode(_requestsReceived);
      if (result.length > 0) {
        result.forEach((element) {
          _.add(FamilyMember.fromJson(element));
        });
        familyRequestsReceived = _;
      }
    }
    // Get Cached Family Members
    String _familyMembers = _prefs.getString('familyMembers');
    if (_familyMembers != null) {
      _ = [];
      List result = json.decode(_familyMembers);
      if (result.length > 0) {
        result.forEach((element) {
          _.add(FamilyMember.fromJson(element));
        });
        familyMembers = _;
      }
    }
    // Get Cached Family Members
    String _requestsSent = _prefs.getString('RequestsSent');
    if (_requestsSent != null) {
      _ = [];
      List result = json.decode(_requestsSent);
      if (result.length > 0) {
        result.forEach((element) {
          _.add(FamilyMember.fromJson(element));
        });
        familyRequestsSent = _;
      }
    }

    notifyListeners();
  }

  /// fetch family data from Server
  Future<ServerResponse> serverData() async {
    ServerResponse familyMembers = await getFamilyMembers();
    return familyMembers;
  }

  /// Get Family Members
  Future<ServerResponse> getFamilyMembers() async {
    Response response = await Api.get("passengers/family/");
    if (response.statusCode == 200) {
      // Parse reponse
      Map<String, dynamic> responseParsed = json.decode(response.body);
      List _familyMembers = responseParsed['familyMembers'];
      List _receivedRequests = responseParsed['receivedRequests'];
      List _sentRequests = responseParsed['sentRequests'];

      // If members isn't empty array
      if (_familyMembers.length > 0) {
        List<FamilyMember> _members = [];
        _familyMembers.forEach((element) {
          FamilyMember member = FamilyMember.fromJson(element);
          _members.add(member);
        });
        // Assign response to App Data
        familyMembers = _members;
      }

      // If members isn't empty array
      if (_receivedRequests.length > 0) {
        List<FamilyMember> _members = [];
        _receivedRequests.forEach((element) {
          FamilyMember member = FamilyMember.fromJson(element);
          _members.add(member);
        });
        // Assign response to App Data
        familyRequestsReceived = _members;
      }

      // If members isn't empty array
      if (_sentRequests.length > 0) {
        List<FamilyMember> _members = [];
        _sentRequests.forEach((element) {
          FamilyMember member = FamilyMember.fromJson(element);
          _members.add(member);
        });
        // Assign response to App Data
        familyRequestsSent = _members;
      }
      notifyListeners();
      return ServerResponse(status: true);
    }
    return ServerResponse(
        status: false, message: "تأكد من اتصالك بالانترنت و حاول مرة اخرى");
  }

  /// Add a member request.
  Future<ServerResponse> makeRequest(Contact contact) async {
    String number = getNumberViewString(contact.phoneNumber.number);
    Response result =
        await Api.put('passengers/family/add', reqBody: {"phone": number});
    if (result.statusCode == 200) {
      // Parsing Contact Data
      String namePreproccessed = contact.fullName;
      List<String> nameProcessed = namePreproccessed.split(" ");
      NameModel namePostprocessed;
      if (nameProcessed.length == 0)
        namePostprocessed = NameModel(first: "غير", last: "معروف");
      else if (nameProcessed.length == 1)
        namePostprocessed = NameModel(first: nameProcessed[0], last: "");
      else
        namePostprocessed =
            NameModel(first: nameProcessed[0], last: nameProcessed[1]);

      // Modify App Data
      familyRequestsSent
          .add(FamilyMember(name: namePostprocessed, phone: number));
      notifyListeners();
      return ServerResponse(status: true);
    } else if (result.statusCode == 408)
      return ServerResponse(status: false, message: "تعذر الوصول للخادم");
    else
      return ServerResponse(status: false, message: "هذا الرقم غير مسجل لدينا");
  }

  /// Cancel a sent request.
  Future<ServerResponse> cancelSentRequest(String phone) async {
    Response result =
        await Api.put('passengers/family/cancel', reqBody: {'phone': phone});
    if (result.statusCode == 200) {
      // remove it from sent requests
      familyRequestsSent = familyRequestsSent
          .where((element) => element.phone != phone)
          .toList();
      notifyListeners();
      return ServerResponse(status: true);
    } else if (result.statusCode == 408)
      return ServerResponse(status: false, message: "تعذر الوصول للخادم");
    else {
      // remove it from sent requests
      familyRequestsSent = familyRequestsSent
          .where((element) => element.phone != phone)
          .toList();
      notifyListeners();
      return ServerResponse(status: false, message: "هذا الطلب غير موجود");
    }
  }

  /// Accept a received request.
  Future<ServerResponse> acceptRequest(String id) async {
    Response result = await Api.put('passengers/family/accept-request',
        reqBody: {'acceptedId': id});
    if (result.statusCode == 200) {
      // Remove member from requests recieved
      int idx =
          familyRequestsReceived.indexWhere((element) => element.id == id);
      // Retreive Lement
      FamilyMember accpetedMember = familyRequestsReceived.removeAt(idx);
      familyMembers.add(accpetedMember);
      notifyListeners();
      return ServerResponse(status: true);
    } else if (result.statusCode == 408)
      return ServerResponse(status: false, message: "تعذر الوصول للخادم");
    else {
      // Remove member from requests recieved
      familyRequestsReceived.removeWhere((element) => element.id == id);
      notifyListeners();
      return ServerResponse(status: false, message: "هذا الطلب لم يعد موجود");
    }
  }

  /// Reject a received rqeuest.
  Future<ServerResponse> rejectRequest(String id) async {
    Response response = await Api.put("passengers/family/deny-request",
        reqBody: {'deniedId': id});
    if (response.statusCode == 200) {
      familyRequestsReceived.removeWhere((element) => element.id == id);
      notifyListeners();
      return ServerResponse(status: true);
    } else if (response.statusCode == 408)
      return ServerResponse(status: false, message: "تعذر الوصول للخادم");
    else {
      // remove it from sent requests
      familyRequestsReceived =
          familyRequestsReceived.where((element) => element.id != id).toList();
      notifyListeners();
      return ServerResponse(status: false, message: "هذا الطلب غير موجود");
    }
  }

  /// Remove a member from your family.
  Future<ServerResponse> removeMember(String id) async {
    String memberName =
        (familyMembers.where((element) => element.id == id).toList())[0]
            .name
            .toString();
    Map<String, dynamic> body = {'_id': id};
    Response result = await Api.put('passengers/family/delete', reqBody: body);
    if (result.statusCode == 200) {
      familyMembers =
          familyMembers.where((element) => element.id != id).toList();
      notifyListeners();
      return ServerResponse(
          status: true, message: "تم ازالة $memberName من اسرتك");
    } else if (result.statusCode == 408)
      return ServerResponse(
          status: false, message: "تأكد من اتصالك بالانترنت و حاول مرة اخرى");
    else {
      // remove it from sent requests
      familyMembers =
          familyMembers.where((element) => element.id != id).toList();
      notifyListeners();
      return ServerResponse(
          status: false, message: "$memberName لما يعد في اسرتك");
    }
  }
}

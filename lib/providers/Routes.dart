// Dart & Other Pacakges
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Flutter Foundation
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
// Models
import 'package:clax/models/Line.dart';
// Services
import 'package:clax/services/Backend.dart';

class RoutesProvider extends ChangeNotifier {
  BuildContext outerContext;
  List<LineModel> lines = [];

  // Static Constructor
  RoutesProvider() {
    init();
  }

  // Async Constructor
  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve Lines from cache
    lines = prefs.getString("lines") == null
        ? []
        : List<LineModel>.from(
            json
                .decode(prefs.getString("lines"))
                .map((card) => LineModel.fromJson(card)),
          ).toList();
    notifyListeners();
    // Retrieve Lines from server
     fetchDataOnline();
  }

  void fetchDataOnline() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Response response = await Api.get('passengers/pairing/line');
    if (response.statusCode == 200) {
      lines = List<LineModel>.from(
        json.decode(response.body).map((line) => LineModel.fromJson(line)),
      ).toList();
      prefs.setString('lines', response.body);
      notifyListeners();
    }
  }
}

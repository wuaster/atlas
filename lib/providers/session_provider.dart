import 'package:flutter/material.dart';
import 'package:atlas/globals.dart';
import 'package:http/http.dart' as http;

class Session with ChangeNotifier {
  String sessionId;

  void getSessionId() async {
    var res = await http.get("$API_BASE/session");
    sessionId = res.body;
    notifyListeners();
  }
}

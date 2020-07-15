import 'package:flutter/material.dart';

class Session with ChangeNotifier {
  String sessionId;

  Session(sessionId) {
    this.sessionId = sessionId;
  }
}

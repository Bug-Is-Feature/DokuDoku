import 'package:dokudoku/model/sessions.dart';
import 'package:dokudoku/services/timer_service.dart';
import 'package:flutter/material.dart';

class SessionProvider extends ChangeNotifier {
  late Future<List<Session>> session = _getSession();

  Future<List<Session>> _getSession() async {
    List<Session> session = await TimerService.getTimerList();
    return session;
  }
}

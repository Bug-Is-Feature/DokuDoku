import 'dart:convert';

import 'package:dokudoku/provider/timer_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

class TimerService {
  static Future<void> saveTimer(
    BuildContext context,
    int bookId,
    int totalDuration,
  ) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    String idToken = await currentUser.getIdToken();

    final response = await http.post(
      Uri.parse("http://${dotenv.env['BACKEND_PATH']}/api/sessions/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken'
      },
      body: jsonEncode({
        'uid': currentUser.uid,
        'book_id': bookId,
        'duration': totalDuration,
      }),
    );

    if (response.statusCode == 201) {
      print('Add session successfully');
    } else {
      print('API_ERROR: ${response.statusCode}');
    }
  }
}

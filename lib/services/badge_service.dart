import 'dart:convert';

import 'package:dokudoku/model/badge.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class BadgeService {
  static Future<List<Badges>> getAllBadges() async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    String idToken = await currentUser.getIdToken();

    final response = await http.get(
      Uri.parse("http://${dotenv.env['BACKEND_PATH']}/api/achievements"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken'
      },
    );

    if (response.statusCode == 200) {
      final utf8Response = utf8.decode(response.bodyBytes);
      final data = jsonDecode(utf8Response);
      return data.map<Badges>((json) => Badges.fromJson(json)).toList();
    } else {
      print('API_ERROR: ${response.statusCode}');
      throw Exception('Failed to load library');
    }
  }
}

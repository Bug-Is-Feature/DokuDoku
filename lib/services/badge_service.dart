import 'dart:convert';

import 'package:dokudoku/model/badge.dart';
import 'package:dokudoku/model/user_badge.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class BadgeService {
//Get all Badges
  static Future<List<Badge>> getAllBadges() async {
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
      return data.map<Badge>((json) => Badge.fromJson(json)).toList();
    } else {
      print('API_ERROR: ${response.statusCode}');
      throw Exception('Failed to load all badges');
    }
  }

  //Get All Badges of user
  static Future<List<UserBadges>> getAllUserBadges() async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    String idToken = await currentUser.getIdToken();
    final response = await http.get(
      Uri.parse("http://${dotenv.env['BACKEND_PATH']}/api/user-achievements"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken'
      },
    );
    if (response.statusCode == 200) {
      final utf8Response = utf8.decode(response.bodyBytes);
      final data = jsonDecode(utf8Response);
      print(data);
      return data.map<UserBadges>((json) => UserBadges.fromJson(json)).toList();
    } else {
      print('API_ERROR: ${response.statusCode}');
      throw Exception('Failed to load all user badges');
    }
  }

  //User unlock badge
  static Future<UserBadges> unlockBadge(int badgeId) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    String idToken = await currentUser.getIdToken();
    final response = await http.post(
      Uri.parse("http://${dotenv.env['BACKEND_PATH']}/api/user-achievements/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken'
      },
      body: jsonEncode({
        'uid': currentUser.uid,
        'unlocked_achievement_id': badgeId,
      }),
    );
    if (response.statusCode == 201) {
      print('Unlock badge successfully');
      final utf8Response = utf8.decode(response.bodyBytes);
      final data = jsonDecode(utf8Response);
      return UserBadges.fromJson(data);
    } else {
      print('API_ERROR: ${response.statusCode}');
      return Future.error('Failed to unlock badge');
    }
  }
}

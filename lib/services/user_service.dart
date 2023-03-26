import 'dart:convert';
import 'package:dokudoku/model/user.dart';
import 'package:dokudoku/provider/timer_provider.dart';
import 'package:dokudoku/provider/user_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ntp/ntp.dart';
import 'package:provider/provider.dart';

Future<String> _formattedNTPWithTimezoneOffset() async {
  String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  DateTime time = await NTP.now();

  final Duration offset = time.timeZoneOffset;
  final int hours = offset.inHours;
  final int minutes = offset.inMinutes.remainder(60).abs().toInt();
  String formattedTime = '';

  if (hours == 0 && minutes == 0) {
    formattedTime = '${time.toIso8601String()}Z';
  } else {
    formattedTime =
        '${time.toIso8601String()}${hours > 0 ? '+' : '-'}${twoDigits(hours.abs())}:${twoDigits(minutes)}';
  }

  return formattedTime;
}

class UserServices {
  static Future<void> createUser() async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    String idToken = await currentUser.getIdToken();

    final response = await http.patch(
      Uri.parse(
          "http://${dotenv.env['BACKEND_PATH']}/api/users/${currentUser.uid}/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken'
      },
      body: jsonEncode({
        'email': currentUser.email,
      }),
    );

    if (response.statusCode == 200) {
      print('Create user successfully');
    } else {
      print('API_ERROR: ${response.statusCode}');
    }
  }

  static Future<void> updateLastLogin() async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    String idToken = await currentUser.getIdToken();
    String time = await _formattedNTPWithTimezoneOffset();

    final response = await http.patch(
      Uri.parse(
          "http://${dotenv.env['BACKEND_PATH']}/api/users/${currentUser.uid}/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken'
      },
      body: jsonEncode({
        'last_login': time,
      }),
    );

    if (response.statusCode == 200) {
      print('Update user last login successfully');
    } else {
      print('API_ERROR: ${response.statusCode}');
    }
  }

  static Future<Users> getUser() async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    String idToken = await currentUser.getIdToken();

    final response = await http.get(
      Uri.parse(
          "http://${dotenv.env['BACKEND_PATH']}/api/users/${currentUser.uid}/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken'
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Users.fromJson(data);
    } else {
      print('API_ERROR: ${response.statusCode}');
      throw Exception('Failed to get user');
    }
  }

  static Future<void> updateExp(BuildContext context, int exp) async {
    final currentUser = FirebaseAuth.instance.currentUser!;
    String idToken = await currentUser.getIdToken();
    final provider = Provider.of<TimerProvider>(context, listen: false);

    final response = await http.patch(
      Uri.parse(
          "http://${dotenv.env['BACKEND_PATH']}/api/users/${currentUser.uid}/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken'
      },
      body: jsonEncode({
        'current_exp': exp,
      }),
    );

    if (response.statusCode == 200) {
      print('Update user exp successfully');
    } else {
      print('API_ERROR: ${response.statusCode}');
    }
  }
}

import 'package:dokudoku/model/user.dart';
import 'package:dokudoku/services/user_service.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  late Future<Users> user = _getUser();
  Future<Users> _getUser() async {
    Users user = await UserServices.getUser();
    return user;
  }
}

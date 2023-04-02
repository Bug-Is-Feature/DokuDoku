import 'package:dokudoku/model/badge.dart' as Badge;
import 'package:dokudoku/model/user_badge.dart';
import 'package:dokudoku/services/badge_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BadgeProvider extends ChangeNotifier {
  // get All Badges method
  late Future<List<Badge.Badge>> badges = _getAllBadges();
  Future<List<Badge.Badge>> _getAllBadges() async {
    List<Badge.Badge> badges = await BadgeService.getAllBadges();
    return badges;
  }

  //get Badge by ID method
  // late Future<List<UserBadges>> userBadges = _getAllUserBadges();
  Future<List<UserBadges>> getAllUserBadges() async {
    List<UserBadges> userBadges = await BadgeService.getAllUserBadges();
    print("${userBadges.length}-----------------------------");
    return userBadges;
  }
}

import 'package:dokudoku/model/badge.dart';
import 'package:dokudoku/services/badge_service.dart';
import 'package:flutter/material.dart';

class BadgeProvider extends ChangeNotifier {
  late Future<List<Badges>> badges = _getAllBadges();
  Future<List<Badges>> _getAllBadges() async {
    List<Badges> badges = await BadgeService.getAllBadges();
    return badges;
  }
}

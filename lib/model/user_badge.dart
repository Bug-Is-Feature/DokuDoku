import 'package:dokudoku/model/user.dart';

class UserBadges {
  final int unlockedAchievementId, userAchievementId;

  UserBadges({
    required this.unlockedAchievementId,
    required this.userAchievementId,
  });

  factory UserBadges.fromJson(json) => UserBadges(
        userAchievementId: json['user_achievement_id'],
        unlockedAchievementId: json['achievement_id'],
      );
  Map<String, dynamic> toJson({required Users user}) => {
        'uid': user.uid,
        'unlocked_achievement_id': unlockedAchievementId,
      };
}

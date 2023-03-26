class UserAchievements {
  final String uid;
  final int unlockedAchievementId;

  UserAchievements({
    required this.uid,
    required this.unlockedAchievementId,
  });

  factory UserAchievements.fromJson(json) => UserAchievements(
        uid: json['uid'],
        unlockedAchievementId: json['unlocked_achievement_id'],
      );
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'unlocked_achievement_id': unlockedAchievementId,
      };
}

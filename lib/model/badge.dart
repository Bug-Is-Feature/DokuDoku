import 'package:dokudoku/model/badge_group.dart';

class Badge {
  final String name, description, lockedThumbnail, unlockedThumbnail, condition;
  final int id, threshold;
  final BadgeGroup group;

  //group
  final bool available;
  Badge(
      {required this.id,
      required this.name,
      required this.description,
      required this.group,
      required this.lockedThumbnail,
      required this.unlockedThumbnail,
      required this.condition,
      required this.threshold,
      required this.available});

  factory Badge.fromJson(json) => Badge(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        group: BadgeGroup.fromJson(json["group"]),
        lockedThumbnail: json["locked_thumbnail"],
        unlockedThumbnail: json["unlocked_thumbnail"],
        condition: json["condition"],
        threshold: json["threshold"],
        available: json["available"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "locked_thumbnail": lockedThumbnail,
        "unlocked_thumbnail": unlockedThumbnail,
        "condition": condition,
        "threshold": threshold,
        "available": available,
      };
}

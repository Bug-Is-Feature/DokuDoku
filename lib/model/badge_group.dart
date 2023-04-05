class BadgeGroup {
  final int id;
  final String name;

  BadgeGroup({
    required this.id,
    required this.name,
  });

  factory BadgeGroup.fromJson(Map<String, dynamic> json) {
    return BadgeGroup(
      id: json['id'],
      name: json['name'],
    );
  }
}

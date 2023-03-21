class Users {
  final String uid, dateJoined, email, lastLogin;
  final int currentLvl, currentExp;
  final bool isAdmin;

  Users({
    required this.uid,
    required this.lastLogin,
    required this.email,
    required this.currentLvl,
    required this.currentExp,
    required this.isAdmin,
    required this.dateJoined,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        uid: json['uid'],
        lastLogin: json['last_login'] ?? json['date_joined'],
        email: json['email'] ?? 'No email',
        currentLvl: json['current_lvl'] ?? -1,
        currentExp: json['current_exp'] ?? -1,
        isAdmin: json['is_admin'] == 0 ? false : true,
        dateJoined: json['date_joined'],
      );
}

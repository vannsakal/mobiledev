enum UserRole { student, teacher }

class User {
  final int id;
  final String name;
  final UserRole role;
  final DateTime? expiresAt;

  User({
    required this.id,
    required this.name,
    required this.role,
    this.expiresAt,
  });

  bool get isExpired =>
      expiresAt != null && DateTime.now().isAfter(expiresAt!);

  static User fromJSon(Map<String, dynamic> json) {
    UserRole role = UserRole.values.firstWhere((e) => e.name == json["role"]);
    return User(
      id: json["id"],
      name: json["name"],
      role: role,
      expiresAt: json["expiresAt"] != null
          ? DateTime.tryParse(json["expiresAt"])
          : null,
    );
  }

  @override
  String toString() {
    return "user = $name - role = ${role.name} - expiresAt = $expiresAt";
  }
}

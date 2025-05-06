class LoggedUser {
  final int id;
  final String name;
  final String email;
  final int score;
  final String type; // Nullable

  LoggedUser({
    required this.id,
    required this.name,
    required this.email,
    required this.score,
    required this.type,
  });

  factory LoggedUser.fromJson(Map<String, dynamic> json) {
    return LoggedUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      score: json['score'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'score': score,
      'type': type,
    };
  }
}

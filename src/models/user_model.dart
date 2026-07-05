class UserModel {
  final String userId;
  final int points;

  UserModel({required this.userId, this.points = 0});

  Map<String, dynamic> toJson() => {'userId': userId, 'points': points};

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userId: json['userId'] as String,
    points: json['points'] as int? ?? 0,
  );
}

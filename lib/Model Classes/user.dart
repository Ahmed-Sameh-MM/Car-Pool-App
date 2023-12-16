import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String uid;
  final String email;
  final String name;
  final int points;
  final int tripsCount;

  User({
    required this.uid,
    required this.email,
    required this.name,
    required this.points,
    required this.tripsCount,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
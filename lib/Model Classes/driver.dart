import 'package:json_annotation/json_annotation.dart';

part 'driver.g.dart';

@JsonSerializable()
class Driver {
  final String uid;
  final String email;
  final String name;
  final int points;
  final int tripsCount;

  Driver({
    required this.uid,
    required this.email,
    required this.name,
    required this.points,
    required this.tripsCount,
  });

  factory Driver.fromJson(Map<dynamic, dynamic> json) => _$DriverFromJson(json);

  Map<String, dynamic> toJson() => _$DriverToJson(this);
}
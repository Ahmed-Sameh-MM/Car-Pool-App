import 'package:json_annotation/json_annotation.dart';

part 'trip.g.dart';

enum TripStatus { // Can be active or previous, there can be only one active reservation
  rejected,
  pending,
  approved,
  completed,
  canceled,
}

@JsonSerializable()
class Trip {
  String id;
  double price;
  String source;
  String destination;
  DateTime currentDate;
  DateTime tripDate;
  Duration time;
  TripStatus status;

  int numberOfSeats;
  List<String>? users;

  Trip({
    required this.id,
    required this.price,
    required this.source,
    required this.destination,
    required this.currentDate,
    required this.tripDate,
    required this.time,
    required this.status,
    
    this.numberOfSeats = 4,
    this.users,
  });

  Trip.empty({
    this.id = "",
    this.price = 10,
    this.source = "",
    this.destination = "",
    this.time = Duration.zero,
    this.status = TripStatus.pending,
    
    this.numberOfSeats = 4,
    this.users = const [],
  }) : currentDate = DateTime(2024), tripDate = DateTime(2024);

  factory Trip.fromJson(Map<dynamic, dynamic> json) => _$TripFromJson(json);

  Map<String, dynamic> toJson() => _$TripToJson(this);
}
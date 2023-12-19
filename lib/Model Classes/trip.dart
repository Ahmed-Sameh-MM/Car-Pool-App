import 'package:json_annotation/json_annotation.dart';

part 'trip.g.dart';

enum TripStatus {
  open,
  fullyReserved,
  completed,
  canceled,
}

enum OrderStatus {
  pending,
  approved,
  completed,
  rejected,
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
  TripStatus tripStatus;

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
    required this.tripStatus,
    
    this.numberOfSeats = 4,
    this.users,
  });

  Trip.empty({
    this.id = "",
    this.price = 10,
    this.source = "",
    this.destination = "",
    this.time = Duration.zero,
    this.tripStatus = TripStatus.open,
    
    this.numberOfSeats = 4,
    this.users = const [],
  }) : currentDate = DateTime(2024), tripDate = DateTime(2024);

  factory Trip.fromJson(Map<dynamic, dynamic> json) => _$TripFromJson(json);

  Map<String, dynamic> toJson() => _$TripToJson(this);
}
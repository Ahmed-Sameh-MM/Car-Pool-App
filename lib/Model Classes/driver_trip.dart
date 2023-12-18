import 'package:car_pool_app/Model%20Classes/trip.dart';

import 'package:json_annotation/json_annotation.dart';

part 'driver_trip.g.dart';

@JsonSerializable()
class DriverTrip extends Trip {

  @JsonKey(includeFromJson: false, includeToJson: true)
  String? driverUid;

  int numberOfSeats;
  List<String>? users;

  DriverTrip({
    required String id,
    required double price,
    required String source,
    required String destination,
    required DateTime currentDate,
    required DateTime tripDate,
    required Duration time,
    required TripStatus status,

    this.driverUid,
    required this.numberOfSeats,
    this.users,
  }) : super(
    id: id,
    price: price,
    source: source,
    destination: destination,
    currentDate: currentDate,
    tripDate: tripDate,
    time: time,
    status: status,
  );

  DriverTrip.empty({
    this.driverUid = "",
    this.numberOfSeats = 0,
    this.users = const [],
  }) : super(
    id: "",
    price: 0,
    source: "",
    destination: "",
    currentDate: DateTime(2024),
    tripDate: DateTime(2024),
    time: Duration.zero,
    status: TripStatus.pending,
  );

  static DriverTrip fullFromJson(Map<dynamic, dynamic> json) => DriverTrip(
    id: json['id'] as String,
    price: (json['price'] as num).toDouble(),
    source: json['source'] as String,
    destination: json['destination'] as String,
    currentDate: DateTime.parse(json['currentDate'] as String),
    tripDate: DateTime.parse(json['tripDate'] as String),
    time: Duration(microseconds: json['time'] as int),
    status: $enumDecode(_$TripStatusEnumMap, json['status']),
    numberOfSeats: json['numberOfSeats'] as int,
    users: (json['users'] as List<dynamic>?)?.map((e) => e as String).toList(),
    driverUid: json['driverUid'] as String,
  );

  factory DriverTrip.fromJson(Map<dynamic, dynamic> json) => _$DriverTripFromJson(json);

  Map<String, dynamic> toJson() => _$DriverTripToJson(this);
}
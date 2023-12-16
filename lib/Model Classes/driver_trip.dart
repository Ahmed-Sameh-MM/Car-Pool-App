import 'package:car_pool_app/Model%20Classes/trip.dart';

import 'package:json_annotation/json_annotation.dart';

part 'driver_trip.g.dart';

@JsonSerializable()
class DriverTrip extends Trip {  
  String driverUid;
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

    required this.driverUid,
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

  factory DriverTrip.fromJson(Map<dynamic, dynamic> json) => _$DriverTripFromJson(json);

  Map<String, dynamic> toJson() => _$DriverTripToJson(this);
}
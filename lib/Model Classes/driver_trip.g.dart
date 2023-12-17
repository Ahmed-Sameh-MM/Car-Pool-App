// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverTrip _$DriverTripFromJson(Map<dynamic, dynamic> json) => DriverTrip(
      id: json['id'] as String,
      price: (json['price'] as num).toDouble(),
      source: json['source'] as String,
      destination: json['destination'] as String,
      currentDate: DateTime.parse(json['currentDate'] as String),
      tripDate: DateTime.parse(json['tripDate'] as String),
      time: Duration(microseconds: json['time'] as int),
      status: $enumDecode(_$TripStatusEnumMap, json['status']),
      numberOfSeats: json['numberOfSeats'] as int,
      users:
          (json['users'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$DriverTripToJson(DriverTrip instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'source': instance.source,
      'destination': instance.destination,
      'currentDate': instance.currentDate.toIso8601String(),
      'tripDate': instance.tripDate.toIso8601String(),
      'time': instance.time.inMicroseconds,
      'status': _$TripStatusEnumMap[instance.status]!,
      'driverUid': instance.driverUid,
      'numberOfSeats': instance.numberOfSeats,
      'users': instance.users,
    };

const _$TripStatusEnumMap = {
  TripStatus.rejected: 'rejected',
  TripStatus.pending: 'pending',
  TripStatus.approved: 'approved',
  TripStatus.completed: 'completed',
  TripStatus.canceled: 'canceled',
};

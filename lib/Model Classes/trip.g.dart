// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trip _$TripFromJson(Map<dynamic, dynamic> json) => Trip(
      id: json['id'] as String,
      price: (json['price'] as num).toDouble(),
      source: json['source'] as String,
      destination: json['destination'] as String,
      currentDate: DateTime.parse(json['currentDate'] as String),
      tripDate: DateTime.parse(json['tripDate'] as String),
      time: Duration(microseconds: json['time'] as int),
      tripStatus: $enumDecode(_$TripStatusEnumMap, json['tripStatus']),
      numberOfSeats: json['numberOfSeats'] as int? ?? 4,
      users:
          (json['users'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TripToJson(Trip instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'source': instance.source,
      'destination': instance.destination,
      'currentDate': instance.currentDate.toIso8601String(),
      'tripDate': instance.tripDate.toIso8601String(),
      'time': instance.time.inMicroseconds,
      'tripStatus': _$TripStatusEnumMap[instance.tripStatus]!,
      'numberOfSeats': instance.numberOfSeats,
      'users': instance.users,
    };

const _$TripStatusEnumMap = {
  TripStatus.open: 'open',
  TripStatus.fullyReserved: 'fullyReserved',
  TripStatus.completed: 'completed',
  TripStatus.canceled: 'canceled',
};

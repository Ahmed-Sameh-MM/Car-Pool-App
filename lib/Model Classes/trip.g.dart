// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trip _$TripFromJson(Map<String, dynamic> json) => Trip(
      id: json['id'] as int,
      price: (json['price'] as num).toDouble(),
      source: json['source'] as String,
      destination: json['destination'] as String,
      date: DateTime.parse(json['date'] as String),
      time: Duration(microseconds: json['time'] as int),
      status: $enumDecode(_$TripStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$TripToJson(Trip instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'source': instance.source,
      'destination': instance.destination,
      'date': instance.date.toIso8601String(),
      'time': instance.time.inMicroseconds,
      'status': _$TripStatusEnumMap[instance.status]!,
    };

const _$TripStatusEnumMap = {
  TripStatus.active: 'active',
  TripStatus.cancelled: 'cancelled',
  TripStatus.pending: 'pending',
  TripStatus.approved: 'approved',
  TripStatus.expired: 'expired',
  TripStatus.confirmed: 'confirmed',
};

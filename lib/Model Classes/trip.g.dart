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
      status: OrderStatus.pending,
      numberOfSeats: json['numberOfSeats'] as int,
      users:
          (json['users'] as List<dynamic>?)?.map((e) => e as String).toList(),
      tripStatus: $enumDecode(_$TripStatusEnumMap, json['tripStatus']),
    );

Map<String, dynamic> _$TripToJson(Trip instance) => <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'source': instance.source,
      'destination': instance.destination,
      'currentDate': instance.currentDate.toIso8601String(),
      'tripDate': instance.tripDate.toIso8601String(),
      'time': instance.time.inMicroseconds,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'driverUid': instance.driverUid,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.rejected: 'rejected',
  OrderStatus.pending: 'pending',
  OrderStatus.approved: 'approved',
  OrderStatus.completed: 'completed',
  OrderStatus.canceled: 'canceled',
};

const _$TripStatusEnumMap = {
  TripStatus.open: 'open',
  TripStatus.fullyReserved: 'fullyReserved',
  TripStatus.approved: 'approved',
  TripStatus.completed: 'completed',
  TripStatus.canceled: 'canceled',
};

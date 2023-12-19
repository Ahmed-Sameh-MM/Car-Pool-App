import 'package:flutter/material.dart';

import 'package:car_pool_app/Model%20Classes/order.dart';

import 'package:json_annotation/json_annotation.dart';

part 'trip.g.dart';

enum TripStatus {
  open,
  fullyReserved,
  approved,
  completed,
  canceled,
}

@JsonSerializable()
class Trip extends Order {

  @JsonKey(includeFromJson: false, includeToJson: true)
  String? driverUid;

  int numberOfSeats;
  List<String>? users;
  TripStatus tripStatus;

  Trip({
    required String id,
    required double price,
    required String source,
    required String destination,
    required DateTime currentDate,
    required DateTime tripDate,
    required Duration time,
    required OrderStatus status,

    this.driverUid,
    required this.numberOfSeats,
    this.users,
    required this.tripStatus,
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

  Trip.empty({
    this.driverUid = "",
    this.numberOfSeats = 0,
    this.users = const [],
    this.tripStatus = TripStatus.open,
  }) : super(
    id: "",
    price: 0,
    source: "",
    destination: "",
    currentDate: DateTime(2024),
    tripDate: DateTime(2024),
    time: Duration.zero,
    status: OrderStatus.pending,
  );

  static Trip fullFromJson(Map<dynamic, dynamic> json) => Trip(
    id: json['id'] as String,
    price: (json['price'] as num).toDouble(),
    source: json['source'] as String,
    destination: json['destination'] as String,
    currentDate: DateTime.parse(json['currentDate'] as String),
    tripDate: DateTime.parse(json['tripDate'] as String),
    time: Duration(microseconds: json['time'] as int),
    status: $enumDecode(_$OrderStatusEnumMap, json['status']),
    numberOfSeats: json['numberOfSeats'] as int,
    users: (json['users'] as List<dynamic>?)?.map((e) => e as String).toList(),
    driverUid: json['driverUid'] as String,
    tripStatus: $enumDecode(_$TripStatusEnumMap, json['tripStatus']),
  );

  factory Trip.fromJson(Map<dynamic, dynamic> json) => _$TripFromJson(json);

  Map<String, dynamic> toJson() => _$TripToJson(this);

  static const tripStatusToJsonString = {
    TripStatus.open: 'open',
    TripStatus.fullyReserved: 'fullyReserved',
    TripStatus.approved: 'approved',
    TripStatus.completed: 'completed',
    TripStatus.canceled: 'canceled',
  };

  static const tripStatusToString = {
    TripStatus.open: 'OPEN',
    TripStatus.fullyReserved: 'FULLY RESERVED',
    TripStatus.approved: 'APPROVED',
    TripStatus.completed: 'COMPLETED',
    TripStatus.canceled: 'CANCELED',
  };

  static const tripStatusToColor = {
    TripStatus.open: Colors.green,
    TripStatus.fullyReserved: Colors.red,
    TripStatus.approved: Colors.green,
    TripStatus.completed: Colors.green,
    TripStatus.canceled: Colors.grey,
  };
}
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

enum OrderStatus { // Can be active or previous, there can be only one active reservation
  rejected,
  pending,
  approved,
  completed,
  canceled,
}

@JsonSerializable()
class Order {
  String id;
  double price;
  String source;
  String destination;
  DateTime currentDate;
  DateTime tripDate;
  Duration time;
  OrderStatus status;

  Order({
    required this.id,
    required this.price,
    required this.source,
    required this.destination,
    required this.currentDate,
    required this.tripDate,
    required this.time,
    required this.status,
  });

  Order.empty({
    this.id = "",
    this.price = 10,
    this.source = "",
    this.destination = "",
    this.time = Duration.zero,
    this.status = OrderStatus.pending,
  }) : currentDate = DateTime(2024), tripDate = DateTime(2024);

  factory Order.fromJson(Map<dynamic, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
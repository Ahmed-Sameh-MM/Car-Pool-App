import 'package:json_annotation/json_annotation.dart';

part 'custom_route.g.dart';

@JsonSerializable()
class CustomRoute {
  String name;
  double price;
  String address;
  String location;

  CustomRoute({
    required this.name,
    required this.price,
    required this.address,
    required this.location,
  });

  CustomRoute.empty({
    this.name = '',
    this.price = 0,
    this.address = '',
    this.location = '',
  });

  void copyWith(CustomRoute route) {
    name = route.name;
    price = route.price;
    address = route.address;
    location = route.location;
  }

  factory CustomRoute.fromJson(Map<String, dynamic> json) => _$CustomRouteFromJson(json);

  Map<String, dynamic> toJson() => _$CustomRouteToJson(this);
}
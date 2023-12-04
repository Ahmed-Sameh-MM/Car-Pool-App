// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomRoute _$CustomRouteFromJson(Map<String, dynamic> json) => CustomRoute(
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      address: json['address'] as String,
      location: json['location'] as String,
    );

Map<String, dynamic> _$CustomRouteToJson(CustomRoute instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'address': instance.address,
      'location': instance.location,
    };

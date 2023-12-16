// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Driver _$DriverFromJson(Map<dynamic, dynamic> json) => Driver(
      uid: json['uid'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      points: json['points'] as int,
      tripsCount: json['tripsCount'] as int,
    );

Map<String, dynamic> _$DriverToJson(Driver instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'name': instance.name,
      'points': instance.points,
      'tripsCount': instance.tripsCount,
    };

import 'package:flutter/material.dart';

import 'package:driver_car_pool_app/Model%20Classes/trip.dart';

class HistoryHelper {
  Future? future;
  String titleText;
  TripStatus status;
  String emptyText;
  String tapText;

  String typeText;
  Color typeColor;

  HistoryHelper({
    required this.future,
    required this.titleText,
    required this.status,
    required this.emptyText,
    this.tapText = "Tap For Details",
    required this.typeText,
    this.typeColor = Colors.green,
  });
}
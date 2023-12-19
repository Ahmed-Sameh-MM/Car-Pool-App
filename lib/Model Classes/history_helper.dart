import 'package:flutter/material.dart';

import 'package:car_pool_app/Model%20Classes/order.dart';

class HistoryHelper {
  Future? future;
  String titleText;
  OrderStatus status;
  String emptyText;
  String tapText;

  String typeText;
  Color typeColor;
  VoidCallback refreshFuture;

  HistoryHelper({
    required this.future,
    required this.titleText,
    required this.status,
    required this.emptyText,
    this.tapText = "Tap For Details",
    required this.typeText,
    this.typeColor = Colors.green,
    required this.refreshFuture,
  });
}
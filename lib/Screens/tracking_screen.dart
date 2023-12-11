import 'package:flutter/material.dart';

import 'package:car_pool_app/Model%20Classes/trip.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({
    super.key,
    required this.trip,
  });

  final Trip trip;

  static const routeName = '/tracking';

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
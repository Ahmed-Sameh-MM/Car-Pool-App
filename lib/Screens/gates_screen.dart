import 'package:flutter/material.dart';

import 'package:driver_car_pool_app/Widgets/gate_widget.dart';

class GatesScreen extends StatelessWidget {
  const GatesScreen({super.key});

  static const routeName = '/gate';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose A Gate'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: GateWidget(),
      ),
    );
  }
}
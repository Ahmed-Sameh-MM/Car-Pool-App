import 'package:car_pool_app/Widgets/sized_box.dart';
import 'package:flutter/material.dart';

import 'package:car_pool_app/Model%20Classes/trip.dart';
import 'package:car_pool_app/Widgets/tracking_column.dart';
import 'package:car_pool_app/Services/realtime_db.dart';
import 'package:car_pool_app/Widgets/custom_button.dart';
import 'package:car_pool_app/Widgets/custom_text.dart';
import 'package:car_pool_app/Offline%20Storage/storage.dart';
import 'package:car_pool_app/Model%20Classes/order.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({
    super.key,
    required this.trip,
  });

  final Trip trip;

  static const routeName = '/tracking';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Your Trip'),
        centerTitle: true,
      ),

      body: Column(
        children: [
          TrackingColumn(
            status: trip.status,
          ),

          const HSizedBox(
            height: 30,
          ),

          trip.status == OrderStatus.pending ? CustomButton(
            width: 120,
            hPadding: 10,
            vPadding: 10,
            onTap: () async {
              final user = await UserStorage.readUser();
              
              await Realtime(uid: user.uid).cancelTrip(trip: trip);

              if(context.mounted) {
                Navigator.pop(context);
              }
            },
            child: const CustomText(
              text: 'Cancel',
              size: 25,
              textColor: Colors.red,
            ),
          ) : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
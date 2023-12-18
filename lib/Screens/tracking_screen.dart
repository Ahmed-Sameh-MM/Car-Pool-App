import 'package:flutter/material.dart';

import 'package:car_pool_app/Model%20Classes/trip.dart';
import 'package:car_pool_app/Widgets/tracking_column.dart';
import 'package:car_pool_app/Services/realtime_db.dart';
import 'package:car_pool_app/Widgets/custom_button.dart';
import 'package:car_pool_app/Widgets/custom_text.dart';
import 'package:car_pool_app/Offline%20Storage/storage.dart';
import 'package:car_pool_app/Model%20Classes/driver_trip.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({
    super.key,
    required this.driverTrip,
  });

  final DriverTrip driverTrip;

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
            status: driverTrip.status,
          ),

          driverTrip.status == TripStatus.pending ? CustomButton(
            onTap: () async {
              final user = await UserStorage.readUser();
              
              await Realtime(uid: user.uid).cancelTrip(driverTrip: driverTrip);

              if(context.mounted) {
                Navigator.pop(context);
              }
            },
            child: const CustomText(
              text: 'Cancel',
              size: 20,
            ),
          ) : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
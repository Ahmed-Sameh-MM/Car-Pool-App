import 'package:flutter/material.dart';

import 'package:driver_car_pool_app/Model%20Classes/trip.dart';
import 'package:driver_car_pool_app/Widgets/tracking_column.dart';
import 'package:driver_car_pool_app/Services/realtime_db.dart';
import 'package:driver_car_pool_app/Widgets/custom_button.dart';
import 'package:driver_car_pool_app/Widgets/custom_text.dart';
import 'package:driver_car_pool_app/Offline%20Storage/storage.dart';
import 'package:driver_car_pool_app/Widgets/sized_box.dart';
import 'package:driver_car_pool_app/Widgets/custom_alert_dialog.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({
    super.key,
    required this.trip,
  });

  final Trip trip;

  static const routeName = '/tracking';

  Widget buttons(BuildContext context) {
    if(trip.tripStatus == TripStatus.open || trip.tripStatus == TripStatus.fullyReserved) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomButton(
            width: 120,
            hPadding: 10,
            vPadding: 10,
            onTap: () async {
              final driver = await DriverStorage.readDriver();

              await Realtime(uid: driver.uid).cancelTrip(tripId: trip.id);

              if(context.mounted) {
                Navigator.pop(context);
              }
            },
            child: const CustomText(
              text: 'Cancel',
              size: 25,
              textColor: Colors.red,
            ),
          ),

          CustomButton(
            width: 130,
            hPadding: 10,
            vPadding: 10,
            onTap: () async {
              final driver = await DriverStorage.readDriver();

              final tripApproval = await Realtime(uid: driver.uid).approveTrip(trip: trip);

              tripApproval.fold(
                (error) {
                  CustomAlertDialog(
                    context: context,
                    error: error,
                    isDismissible: false,
                    onPressed: () {
                      Navigator.pop(context);
                    }
                  );
                },
                (approved) {
                  if(context.mounted) {
                    Navigator.pop(context);
                  }
                },
              );
            },
            child: const CustomText(
              text: 'Approve',
              size: 25,
              textColor: Colors.green,
            ),
          ),
        ],
      );
    }

    else if(trip.tripStatus == TripStatus.approved) {
      return CustomButton(
        width: 150,
        hPadding: 10,
        vPadding: 10,
        onTap: () async {
          final driver = await DriverStorage.readDriver();

          await Realtime(uid: driver.uid).completeTrip(tripId: trip.id);

          if(context.mounted) {
            Navigator.pop(context);
          }
        },
        child: const CustomText(
          text: 'Complete',
          size: 25,
        ),
      );
    }

    return const SizedBox.shrink();
  }

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
            status: trip.tripStatus,
          ),

          const HSizedBox(
            height: 30,
          ),

          buttons(context),
        ],
      ),
    );
  }
}
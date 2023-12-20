import 'package:flutter/material.dart';

import 'package:driver_car_pool_app/Screens/gates_screen.dart';
import 'package:driver_car_pool_app/Screens/routes_screen.dart';
import 'package:driver_car_pool_app/Widgets/custom_button.dart';
import 'package:driver_car_pool_app/Widgets/custom_text.dart';
import 'package:driver_car_pool_app/Widgets/sized_box.dart';
import 'package:driver_car_pool_app/State%20Management/providers.dart';
import 'package:driver_car_pool_app/Static%20Data/constants.dart';
import 'package:driver_car_pool_app/Services/general_functions.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class PathScreen extends ConsumerWidget {
  const PathScreen({super.key});

  static const routeName = '/path';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose A Path'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              shadow: false,
              onTap: () {
                ref.read(routeTypeProvider.notifier).state = RouteType.anyToAinshams;
                ref.read(tripProvider).time = timeSlots[0];
                
                Navigator.pushNamed(context, RoutesScreen.routeName);
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const CustomText(
                      text: 'From: Any Location',
                      size: 20,
                    ),
              
                    const HSizedBox(
                      height: 30,
                    ),
              
                    const CustomText(
                      text: 'To: Ain Shams',
                      size: 20,
                    ),

                    const HSizedBox(
                      height: 10,
                    ),
              
                    CustomText(
                      text: "(${durationToTime(timeSlots[0])})",
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
      
            const HSizedBox(
              height: 50,
            ),
      
            CustomButton(
              shadow: false,
              onTap: () {
                ref.read(routeTypeProvider.notifier).state = RouteType.ainshamsToAny;
                ref.read(tripProvider).time = timeSlots[1];

                Navigator.pushNamed(context, GatesScreen.routeName);
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const CustomText(
                      text: 'From: Ain Shams',
                      size: 20,
                    ),
              
                    const HSizedBox(
                      height: 30,
                    ),
              
                    const CustomText(
                      text: 'To: Any Location',
                      size: 20,
                    ),

                    const HSizedBox(
                      height: 10,
                    ),
              
                    CustomText(
                      text: "(${durationToTime(timeSlots[1])})",
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
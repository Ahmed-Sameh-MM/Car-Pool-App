import 'package:flutter/material.dart';

import 'package:driver_car_pool_app/Screens/register_screen.dart';
import 'package:driver_car_pool_app/Widgets/custom_button.dart';
import 'package:driver_car_pool_app/Widgets/custom_text.dart';
import 'package:driver_car_pool_app/Widgets/sized_box.dart';

class Interface extends StatelessWidget {
  const Interface({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(
              text: 'Driver Car Pool',
              size: 50,
            ),

            const HSizedBox(
              height: 20,
            ),

            const Icon(
              Icons.call_merge_rounded,
              size: 50,
              color: Colors.white,
            ),
      
            const HSizedBox(
              height: 100,
            ),
      
            CustomButton(
              shadow: false,
              width: 200,
              height: 80,
              onTap: () {
                Navigator.pushNamed(context, RegisterScreen.routeName);
              },
              child: const CustomText(
                text: 'Get Started',
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'package:car_pool_app/Static%20Data/constants.dart';
import 'package:car_pool_app/Widgets/custom_button.dart';
import 'package:car_pool_app/Widgets/custom_text.dart';
import 'package:car_pool_app/Widgets/sized_box.dart';
import 'package:car_pool_app/Screens/main_screen.dart';

class GateWidget extends StatelessWidget {
  const GateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: gates.length,
            separatorBuilder: (context, index) => const HSizedBox(
              height: 50,
            ),
            itemBuilder: (context, index) {
              return CustomButton(
                shadow: false,
                onTap: () {
                  Navigator.pushNamed(context, MainScreen.routeName);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: CustomText(
                    text: gates[index],
                    size: 20,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
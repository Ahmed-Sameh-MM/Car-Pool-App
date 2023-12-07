import 'package:flutter/material.dart';

import 'package:car_pool_app/Static%20Data/constants.dart';
import 'package:car_pool_app/Widgets/custom_button.dart';
import 'package:car_pool_app/Widgets/custom_text.dart';
import 'package:car_pool_app/Widgets/sized_box.dart';
import 'package:car_pool_app/Screens/routes_screen.dart';
import 'package:car_pool_app/State%20Management/providers.dart';
import 'package:car_pool_app/Screens/chosen_route_screen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class GateWidget extends ConsumerWidget {
  const GateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  final routeType = ref.read(routeTypeProvider);
                  
                  if(routeType == RouteType.anyToAinshams) {
                    final chosenRouteData = ref.read(chosenRouteProvider);
                    Navigator.pushNamed(context, ChosenRouteScreen.routeName, arguments: chosenRouteData);
                  }

                  else if(routeType == RouteType.ainshamsToAny) {
                    Navigator.pushNamed(context, RoutesScreen.routeName);
                  }
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
import 'package:flutter/material.dart';

import 'package:car_pool_app/Screens/chosen_route_screen.dart';
import 'package:car_pool_app/Widgets/custom_button.dart';
import 'package:car_pool_app/Widgets/custom_text.dart';
import 'package:car_pool_app/Widgets/sized_box.dart';
import 'package:car_pool_app/Model%20Classes/custom_route.dart';
import 'package:car_pool_app/Screens/gates_screen.dart';
import 'package:car_pool_app/State%20Management/providers.dart';
import 'package:car_pool_app/Static%20Data/constants.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoutesListView extends ConsumerWidget {
  const RoutesListView({
    super.key,
    required this.routes,
  });

  final List<CustomRoute> routes;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: routes.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20,),
          child: CustomButton(
            shadow: false,
            borderRadius: 5,
            onTap: () {
              final routeData = routes[index];

              ref.read(chosenRouteProvider).copyWith(routeData);

              // set the price of the trip based on the chosen route
              ref.read(tripProvider).price = routeData.price;

              final routeType = ref.read(routeTypeProvider);

              if(routeType == RouteType.anyToAinshams) {
                ref.read(tripProvider).source = routeData.name;

                Navigator.pushNamed(context, GatesScreen.routeName);
              }
              
              else if(routeType == RouteType.ainshamsToAny) {
                ref.read(tripProvider).destination = routeData.name;

                Navigator.pushNamed(context, ChosenRouteScreen.routeName, arguments: routeData);
              }
            },
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/${routes[index].name}.jpg'
                      ),
                      opacity: .8,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: routes[index].name,
                        size: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      const HSizedBox(
                        height: 10,
                      ),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_pin),
                              CustomText(
                                text: routes[index].address,
                                size: 13,
                                textColor: Colors.white60,
                              ),
                            ],
                          ),
                          CustomText(
                            text: '${routes[index].price} EGP',
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
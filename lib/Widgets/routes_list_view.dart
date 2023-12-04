import 'package:flutter/material.dart';

import 'package:car_pool_app/Screens/chosen_route_screen.dart';
import 'package:car_pool_app/Widgets/custom_button.dart';
import 'package:car_pool_app/Widgets/custom_text.dart';
import 'package:car_pool_app/Widgets/sized_box.dart';
import 'package:car_pool_app/Model%20Classes/custom_route.dart';

class RoutesListView extends StatelessWidget {
  const RoutesListView({
    super.key,
    required this.routes,
  });

  final List<CustomRoute> routes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: routes.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20,),
          child: CustomButton(
            shadow: false,
            borderRadius: 5,
            onTap: () {
              final locationData = routes[index];
              Navigator.pushNamed(context, ChosenRouteScreen.routeName,arguments: locationData);
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
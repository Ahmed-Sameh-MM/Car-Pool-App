import 'package:car_pool_app/Services/general_functions.dart';
import 'package:flutter/material.dart';

import 'package:car_pool_app/Widgets/sized_box.dart';
import 'package:car_pool_app/Widgets/custom_text.dart';
import 'package:car_pool_app/Widgets/custom_container.dart';
import 'package:car_pool_app/Static%20Data/colors.dart';
import 'package:car_pool_app/Widgets/custom_button.dart';
import 'package:car_pool_app/Widgets/promo_code_field.dart';
import 'package:car_pool_app/State%20Management/providers.dart';
import 'package:car_pool_app/Offline%20Storage/storage.dart';
import 'package:car_pool_app/Services/errors.dart';
import 'package:car_pool_app/Services/realtime_db.dart';
import 'package:car_pool_app/Widgets/wrapper.dart';
import 'package:car_pool_app/Services/trip_id_generator.dart';
import 'package:car_pool_app/Services/date.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({ super.key });

  static const routeName = '/checkout';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chosenRoute = ref.watch(chosenRouteProvider);

    final trip = ref.watch(tripProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout Screen'),
        centerTitle: true,
      ),
      
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/${chosenRoute.name}.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: chosenRoute.name,
                    size: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  
                  const HSizedBox(
                    height: 10,
                  ),

                  Row(
                    children: [
                      const Icon(
                        Icons.location_pin,
                        color: Colors.white,
                      ),
                      const WSizedBox(
                        width: 5,
                      ),
                      CustomText(
                        text: chosenRoute.address,
                        size: 16,
                      ),
                    ],
                  ),

                  const HSizedBox(
                    height: 20,
                  ),

                  const CustomText(
                    text: 'Date & Time',
                    size: 16,
                    fontWeight: FontWeight.bold,
                  ),

                  const HSizedBox(
                    height: 15,
                  ),

                  CustomContainer(
                    shadow: false,
                    color: primaryColor,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                            ),
                            const WSizedBox(
                              width: 10,
                            ),
                            CustomText(
                              text: formatDate(trip.tripDate),
                              size: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),

                        const HSizedBox(
                          height: 25,
                        ),
                        
                        CustomContainer(
                          shadow: true,
                          borderRadius: 8,
                          child: CustomText(
                            text: durationToTime(trip.time),
                            size: 20,
                            fontWeight: FontWeight.bold,
                            textColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const HSizedBox(
                    height: 30,
                  ),

                  const CustomText(
                    text: 'Promo code',
                    size: 16,
                    fontWeight: FontWeight.bold,
                  ),

                  const HSizedBox(
                    height: 10,
                  ),

                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: PromoCodeField(
                          controller: TextEditingController(),
                          focusNode: FocusNode(),
                        ),
                      ),

                      const WSizedBox(
                        width: 20,
                      ),

                      Expanded(
                        flex: 1,
                        child: CustomButton(
                          height: 50,
                          shadow: false,
                          onTap: () {},
                          child: const CustomText(
                            text: 'Apply',
                          ),
                        ),
                      ),
                    ],
                  ),

                  const HSizedBox(
                    height: 30,
                  ),

                  const Center(
                    child: CustomText(
                      text: 'Payment Summary',
                      size: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const HSizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: 'fee',
                      ),

                      CustomText(
                        text: 'EGP ${chosenRoute.price}',
                      ),
                    ],
                  ),
                  
                  const HSizedBox(
                    height: 10,
                  ),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Discount',
                      ),
                      CustomText(
                        text: '- EGP 0.00',
                      ),
                    ],
                  ),

                  const HSizedBox(
                    height: 10,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: 'Total amount',
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                        text: 'EGP ${chosenRoute.price}',
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),

                  const HSizedBox(
                    height: 30,
                  ),
                  
                  CustomButton(
                    height: 50,
                    child: const CustomText(
                      text: 'Confirm Trip',
                    ),
                    onTap: () async {
                      final user = await UserStorage.readUser();

                      final date = await Date.fetchDate();

                      date.fold(
                        (error) {},
                        (right) async {
                          ref.read(tripProvider).id = TripIdGenerator().getRandomString(6);
                          ref.read(tripProvider).currentDate = right;

                          final trip = ref.read(tripProvider);
                          final tripReservation = await Realtime(uid: user.uid).reserve(
                            trip: trip,
                          );
                
                          tripReservation.fold(
                            (error) {
                              if(error is ConnectionError || error is FirebaseError) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.errorMessage)));
                              }
                              
                              else if(error is LateReservationError) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.errorMessage)));
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }
                            },
                            (right) async {
                              // await Storage().addHistory(reservationHistory);
                                  
                              // userData.accountStatus = AccountStatus.active;
                              // userData.reservationsCounter += 1;

                              // await Storage().updateUserAccountStatus(userData);
                              // await Storage().incrementReservationsCounter(userData);
            
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Successful Reservation")));
                              
                              Navigator.popUntil(context, ModalRoute.withName(Wrapper.routeName));
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'package:car_pool_app/Widgets/sized_box.dart';
import 'package:car_pool_app/Widgets/custom_text.dart';
import 'package:car_pool_app/Widgets/custom_container.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({ super.key });

  static const routeName = '/checkout';

  @override
  Widget build(BuildContext context) {
    final checkoutRouteArguments = ModalRoute.of(context)!.settings.arguments;
    
    // final reservationHistory = checkoutRouteArguments.reservationHistory;
    // final List<int> slotsTime = reservationHistory.slots.split("-").map( (e) => int.parse(e)).toList(); // ('2-3') -> ['2', '3'] -> [2, 3]
    
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
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/.png',
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
                  //Text('${reservationHistory.schoolName} School' , style: Theme.of(context).textTheme.headline5,),
                  CustomText(
                    text: 'School Name',
                    size: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  
                  const HSizedBox(
                    height: 10,
                  ),

                  Row(
                    children: [
                      const Icon(Icons.sports_soccer),
                      const WSizedBox(
                        width: 5,
                      ),
                      CustomText(
                        text: 'Field',
                        size: 16,
                      ),
                    ],
                  ),

                  const HSizedBox(
                    height: 5,
                  ),

                  Row(
                    children: [
                      const Icon(Icons.location_pin),
                      const WSizedBox(
                        width: 5,
                      ),
                      CustomText(
                        text: 'Fifth Settlement',
                        size: 16,
                      ),
                    ],
                  ),

                  const HSizedBox(
                    height: 20,
                  ),

                  CustomText(
                    text: 'Date & Time',
                    size: 16,
                    fontWeight: FontWeight.bold,
                  ),

                  const HSizedBox(
                    height: 15,
                  ),

                  CustomContainer(
                    shadow: true,
                    color: const Color(0xFFF0F0F0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.calendar_today),
                            const WSizedBox(
                              width: 10,
                            ),
                            CustomText(
                              text: 'dateFormat(reservationHistory.reservationDate)',
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        const HSizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                const CustomText(
                                  text: 'From',
                                  fontWeight: FontWeight.w600,
                                  textColor: Color(0xFF616161),
                                ),

                                const HSizedBox(
                                  height: 10,
                                ),

                                CustomContainer(
                                  shadow: true,
                                  borderRadius: 8,
                                  child: CustomText(
                                    text: 'timeSlotTitle(slotsTime[0], 00)',
                                    size: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_right_alt,
                              size: 90,
                            ),
                            Column(
                              children: [
                                const CustomText(
                                  text: 'To',
                                  fontWeight: FontWeight.w600,
                                  textColor: Color(0xFF616161),
                                ),

                                const HSizedBox(
                                  height: 10,
                                ),

                                CustomContainer(
                                  shadow: true,
                                  borderRadius: 8,
                                  child: CustomText(
                                    text: 'timeSlotTitle(slotsTime[1], :00)',
                                    size: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const HSizedBox(
                    height: 20,
                  ),
                  CustomText(
                    text: 'Pay with',
                    size: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  const HSizedBox(
                    height: 20,
                  ),
                  CustomText(
                    text: 'Promo code',
                    size: 16,
                    fontWeight: FontWeight.bold,
                  ),

                  const HSizedBox(
                    height: 20,
                  ),

                  CustomText(
                    text: 'Payment Summary',
                    size: 16,
                    fontWeight: FontWeight.bold,
                  ),

                  const HSizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'fee',
                      ),

                      CustomText(
                        text: 'EGP price.00',
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
                        text: 'EGP price.00',
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  
                  TextButton(
                    child: const Text('Confirm Booking'),
                    onPressed: () async {
                      // final reservation = await Realtime(phoneNumber: '01111111111111').reserve(
                      //   reservationHistory: reservationHistory,
                      // );
            
                      // reservation.fold(
                      //   (error) {
                      //     if(error is ConnectionError) {
                      //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.errorMessage)));
                      //     }
                      //     else if(error is FirebaseError) {
                      //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.errorMessage)));
                      //     }
                      //     else if(error is AlreadyReservedError) {
                      //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.errorMessage)));
                      //       Navigator.pop(context);
                      //     }
                      //   },
                      //   (right) async {
                      //     final history = await Firestore(phoneNumber: userData.phoneNumber).addReservationHistory(reservationHistory);
            
                      //     history.fold(
                      //       (error) {},
                      //       (right) async {
                      //         await Storage().addHistory(reservationHistory);
                              
                      //         userData.accountStatus = AccountStatus.active;
                      //         userData.reservationsCounter += 1;
                      //         await Storage().updateUserAccountStatus(userData);
                      //         await Storage().incrementReservationsCounter(userData);
            
                      //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successful Reservation")));
                      //         // TODO handle the stopwatch, either stop and reset it or stop it only, just dispose it
                      //         Navigator.popUntil(context, ModalRoute.withName(Wrapper.routeName));
                      //       },
                      //     );
                      //   },
                      // );
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
import 'package:flutter/material.dart';

import 'package:car_pool_app/Widgets/sized_box.dart';
import 'package:car_pool_app/Widgets/custom_text.dart';
import 'package:car_pool_app/Widgets/custom_container.dart';
import 'package:car_pool_app/Model%20Classes/location.dart';
import 'package:car_pool_app/Screens/payment_screen.dart';
import 'package:car_pool_app/Static%20Data/colors.dart';
import 'package:car_pool_app/Widgets/custom_button.dart';
import 'package:car_pool_app/Widgets/promo_code_field.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({ super.key });

  static const routeName = '/checkout';

  @override
  Widget build(BuildContext context) {
    final chosenLocation = ModalRoute.of(context)!.settings.arguments as Location;
    
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
                    'assets/images/${chosenLocation.name}.jpg',
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
                    text: chosenLocation.name,
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
                        text: chosenLocation.address,
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
                              text: 'dateFormat(1/1/2023)',
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),

                        const HSizedBox(
                          height: 15,
                        ),
                        
                        CustomContainer(
                          shadow: true,
                          borderRadius: 8,
                          child: CustomText(
                            text: '7:30 AM',
                            size: 18,
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
                      CustomText(
                        text: 'fee',
                      ),

                      CustomText(
                        text: 'EGP ${chosenLocation.price}',
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
                        text: 'EGP ${chosenLocation.price}',
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
                      text: 'Confirm Booking',
                    ),
                    onTap: () async {
                      Navigator.pushNamed(context, PaymentScreen.routeName);
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
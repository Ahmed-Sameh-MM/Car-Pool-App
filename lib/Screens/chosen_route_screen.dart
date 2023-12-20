import 'package:flutter/material.dart';

import 'package:driver_car_pool_app/Model%20Classes/custom_route.dart';
import 'package:driver_car_pool_app/Services/date.dart';
import 'package:driver_car_pool_app/Widgets/custom_button.dart';
import 'package:driver_car_pool_app/Widgets/custom_text.dart';
import 'package:driver_car_pool_app/Widgets/shimmer_template.dart';
import 'package:driver_car_pool_app/Widgets/sized_box.dart';
import 'package:driver_car_pool_app/Static%20Data/colors.dart';
import 'package:driver_car_pool_app/Services/general_functions.dart';
import 'package:driver_car_pool_app/Static%20Data/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:driver_car_pool_app/State%20Management/providers.dart';
import 'package:driver_car_pool_app/Screens/checkout_screen.dart';
import 'package:driver_car_pool_app/Widgets/custom_alert_dialog.dart';

import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ChosenRouteScreen extends StatefulWidget {

  final CustomRoute routeData;

  const ChosenRouteScreen({
    super.key,
    required this.routeData,
  });

  static const routeName = '/chosen_route';
  
  @override
  State<ChosenRouteScreen> createState() => _ChosenRouteScreenState();
}

class _ChosenRouteScreenState extends State<ChosenRouteScreen> {

  late int selectedTimeSlot;
  int selectedDateSlot = 0; // currently selected date slot

  late final CustomRoute chosenRouteData;

  DateTime? currentDate;

  List<String> dayNames = ['Today']; // Placeholder for the NAME of the current day and the next 6 days
  List<String> dayDates = []; // Placeholder for the DATE NUMBER of the current day and 6 days

  final double bottomSheetHeight = 160;

  void dayNameAndDayDatesGenerator() async {

    final date = await Date.fetchDate();

    date.fold(
      (error) {
        CustomAlertDialog(
          context: context,
          error: error,
        );
      },
      (right) {
        
        setState(() {
          currentDate = right;
        });

        dayDates.add(currentDate!.day.toString());

        for(int i = 1; i <= 7; i++){
          dayNames.add(DateFormat('EEEE').format(currentDate!.add(Duration(days: i))));

          dayDates.add(currentDate!.add(Duration(days: i)).day.toString());
        }
      },
    );
  }

  Widget bookNowSheet() {
    if(currentDate != null) {
      return Container(
        height: bottomSheetHeight,
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                text: 'Your Booking',
                size: 16,
                fontWeight: FontWeight.bold,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CustomText(
                        text: formatDate(currentDate!.add(Duration(days: selectedDateSlot))),
                      ),
                      CustomText(
                        text: durationToTime(timeSlots[selectedTimeSlot]),
                      ),
                    ],
                  ),
        
                  const WSizedBox(
                    width: 50,
                  ),
        
                  CustomText(
                    text: 'Price: ${chosenRouteData.price} Egp',
                    size: 16,
                  ),
                ],
              ),

              const HSizedBox(
                height: 30,
              ),

              Consumer(
                builder: (context, ref, child) {
                  return CustomButton(
                    width: 200,
                    height: 50,
                    color: Colors.white,
                    onTap: () {
                      final tripDate = currentDate!.add(Duration(
                        days: selectedDateSlot,
                      ));
                      ref.read(tripProvider).tripDate = DateTime(tripDate.year, tripDate.month, tripDate.day);
                      
                      Navigator.pushNamed(context, CheckoutScreen.routeName);
                    },
                    child: const Center(
                      child: CustomText(
                        text: 'Book Now',
                        size: 16,
                        textColor: Colors.black,
                      ),
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      );
    }
    
    return Container(
      width: double.infinity,
      height: bottomSheetHeight - 30,
      color: primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: CustomText(
              text: 'Choose Date',
              size: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          Column(
            children: [
              CustomText(
                text: 'Trip Price (${chosenRouteData.price} EGP)',
              ),
              const TextButton(
                onPressed: null,
                child: CustomText(
                  text: 'Book Now',
                  textColor: Colors.white24,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  @override
  void initState() {
    chosenRouteData = widget.routeData;
    
    dayNameAndDayDatesGenerator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {

        selectedTimeSlot = (ref.watch(tripProvider).time == timeSlots[0]) ? 0 : 1;
        
        return Scaffold(
          bottomSheet: bookNowSheet(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage('assets/images/${chosenRouteData.name}.jpg'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: chosenRouteData.name,
                        size: 24,
                        fontWeight: FontWeight.bold,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.location_pin,
                                color: Colors.white,
                              ),
                              CustomText(
                                text: chosenRouteData.address,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const CustomText(
                                text: 'Location',
                                size: 13,
                              ),

                              const HSizedBox(
                                height: 5,
                              ),

                              CustomButton(
                                onTap: () async {

                                  final url = Uri.parse(chosenRouteData.location);

                                  if(await canLaunchUrl(url)) {
                                    await launchUrl(url);
                                  }

                                  else {
                                    if(context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Can't launch this URL, please check your browser")));
                                    }
                                  }
                                },
                                height: 32,
                                width: 55,
                                borderRadius: 3,
                                color: Colors.black,
                                child: const Icon(
                                  Icons.location_pin,
                                  color: Colors.greenAccent,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const HSizedBox(
                        height: 20,
                      ),

                      const CustomText(
                        text: 'Chosen Time',
                        size: 16,
                        fontWeight: FontWeight.bold,
                      ),

                      const HSizedBox(
                        height: 10,
                      ),
                      
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          itemCount: timeSlots.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 20,),
                              width: 100,
                              height: 100,
                              child: CustomButton(
                                shadow: false,
                                borderRadius: 8,
                                color: primaryColor,
                                selectedColor: const Color(0xFF4967FF),
                                selectedChildrenColor: Colors.black,
                                onTap: null,
                                selected: (index == selectedTimeSlot),
                                child: Center(
                                  child: Text(durationToTime(timeSlots[index])),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const HSizedBox(
                        height: 40,
                      ),

                      const CustomText(
                        text: 'Select a Date',
                        size: 16,
                        fontWeight: FontWeight.bold,
                      ),

                      const HSizedBox(
                        height: 10,
                      ),

                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 7,
                          itemBuilder: (context, index) {

                            if(currentDate == null) {
                              return const ShimmerTemplate(
                                width: 65,
                                height: 100,
                                margin: EdgeInsets.only(right: 10,),
                              );
                            }
                            
                            return Container(
                              margin: const EdgeInsets.only(right: 10,),
                              width: 65,
                              height: 100,
                              child: ListTileTheme(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                tileColor: primaryColor,
                                
                                selectedColor: Colors.black,
                                selectedTileColor: const Color(0xFF7323FF),
                                
                                child: ListTile(
                                  title: Column(
                                    children: [
                                      Text( dayNames[index].substring(0,3) ),
                                      Text( dayDates[index] ),
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectedDateSlot = index;
                                    });
                                  },
                                  selected: ( index == selectedDateSlot ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 30,),
                      
                      HSizedBox(
                        height: bottomSheetHeight + 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
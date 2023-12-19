import 'package:flutter/material.dart';

import 'package:car_pool_app/Model%20Classes/trip.dart';
import 'package:car_pool_app/Offline%20Storage/storage.dart';
import 'package:car_pool_app/Services/realtime_db.dart';
import 'package:car_pool_app/Widgets/custom_button.dart';
import 'package:car_pool_app/Widgets/custom_container.dart';
import 'package:car_pool_app/Widgets/custom_text.dart';
import 'package:car_pool_app/Widgets/sized_box.dart';
import 'package:car_pool_app/Services/general_functions.dart';
import 'package:car_pool_app/Screens/payment_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:car_pool_app/State%20Management/providers.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class TripsScreen extends StatefulWidget {

  final Trip trip;

  const TripsScreen({
    super.key,
    required this.trip,
  });

  static const routeName = '/trips';

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {

  Future? tripsFuture;

  Future< List<Trip> > initTrips() async {
    final user = await UserStorage.readUser();

    final temp = await Realtime(uid: user.uid).filterTrips(trip: widget.trip);

    return temp.fold(
      (error) {
        return Future< List<Trip> >.error(error);
      },
      (trips) {
        return Future< List<Trip> >.value(trips);
      },
    );
  }

  @override
  void initState() {
    tripsFuture = initTrips();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trips Screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: CustomText(
                text: "Available Trips",
                size: 16,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
      
            const HSizedBox(
              height: 25,
            ),
      
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: FutureBuilder(
                initialData: null,
                future: tripsFuture,
                builder: (context, snapshot) {
                  switch(snapshot.connectionState){
                    case ConnectionState.none:
                      return const Text('Error Loading the Data');
                    
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      return const SpinKitRing(
                        color: Colors.red,
                        size: 50,
                      );
                      
                    case ConnectionState.done:
                      if(snapshot.hasError) {
                        return Center(
                          child: CustomText(
                            text: snapshot.error.toString(),
                            size: 16,
                          ),
                        );
                      }
                      
                      else if(snapshot.hasData){
                        List<Trip> trips = snapshot.data;
      
                        if(trips.isEmpty) {
                          return const Center(
                            child: CustomText(
                              text: "No Available Trips !",
                              size: 18,
                            ),
                          );
                        }
                        
                        else{
                          return SizedBox(
                            height: trips.length * 180,
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: trips.length,
                              scrollDirection: Axis.vertical,
                              separatorBuilder: (context, index) {
                                return const HSizedBox(
                                  height: 25,
                                );
                              },
                              itemBuilder: (context, index) {
                                return Consumer(
                                  builder: (context, ref, child) {
                                    return CustomButton(
                                      hPadding: 10,
                                      vPadding: 10,
                                      onTap: () {
                                        ref.read(tripProvider).id = trips[index].id;

                                        ref.read(tripProvider).driverUid = trips[index].driverUid;
                                        ref.read(tripProvider).numberOfSeats = trips[index].numberOfSeats;
                                        ref.read(tripProvider).users = trips[index].users;

                                        Navigator.pushNamed(context, PaymentScreen.routeName);
                                      },
                                      child: Stack(
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/images/${trips[index].destination}.jpg',
                                                    width: 65,
                                                    height: 65,
                                                    fit: BoxFit.fill,
                                                  ),
                          
                                                  const WSizedBox(
                                                    width: 10,
                                                  ),
                          
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      CustomText(
                                                        text: trips[index].source,
                                                        size: 16,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                          
                                                      const HSizedBox(
                                                        height: 5,
                                                      ),
                          
                                                      CustomText(
                                                        text: "To",
                                                        fontWeight: FontWeight.w600,
                                                        fontFamily: GoogleFonts.poppins().fontFamily,
                                                        textColor: Colors.white30,
                                                      ),
                          
                                                      const HSizedBox(
                                                        height: 5,
                                                      ),
                          
                                                      CustomText(
                                                        text: trips[index].destination,
                                                        size: 16,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                          
                                              const HSizedBox(
                                                height: 10,
                                              ),
                          
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CustomText(
                                                            text: formatDate(trips[index].tripDate),
                                                            fontWeight: FontWeight.bold,
                                                          ),
                          
                                                          const WSizedBox(
                                                            width: 20,
                                                          ),
                          
                                                          CustomText(
                                                            text: durationToTime(trips[index].time),
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ],
                                                      ),
                                                      
                                                      const HSizedBox(
                                                        height: 10,
                                                      ),
                          
                                                      const CustomText(
                                                        text: "Tap to Reserve",
                                                        textColor: Colors.white38,
                                                      ),
                                                    ],
                                                  ),
                                                  CustomText(
                                                    text: '${trips[index].price} EGP',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Positioned(
                                            right: 1,
                                            child: CustomContainer(
                                              vpadding: 5,
                                              hpadding: 5,
                                              borderRadius: 5,
                                              color: trips[index].numberOfSeats > 1 ? Colors.green : Colors.red,
                                              child: CustomText(
                                                text: trips[index].numberOfSeats.toString(),
                                                textColor: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                );
                              }
                            ),
                          );
                        }
                      }
                      return const Text('error retrieving the data, please try again');
                    default:
                      return const Text('Default');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:car_pool_app/Model%20Classes/custom_route.dart';
import 'package:car_pool_app/Widgets/custom_container.dart';
import 'package:flutter/material.dart';

import 'package:car_pool_app/Widgets/custom_text.dart';
import 'package:car_pool_app/Widgets/custom_button.dart';
import 'package:car_pool_app/Widgets/sized_box.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({ super.key });

  static const routeName = '/history';

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  Future? historyFuture = Future.delayed(const Duration(milliseconds: 500), () => CustomRoute.getCustomRoutes()[0],);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History Screen'),
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
                text: 'Active Trips',
                size: 16,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),

            const HSizedBox(
              height: 15,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: FutureBuilder(
                initialData: null,
                future: historyFuture,
                builder: (context, snapshot) {
                  switch(snapshot.connectionState){
                    case ConnectionState.none:
                      return Text('Error Loading the Data');
                    
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      return const SpinKitRing(
                        color: Colors.red,
                        size: 50,
                      );
                      
                    case ConnectionState.done:
                      if(snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      
                      else if(snapshot.hasData){
                        CustomRoute? activeBooking;

                        activeBooking = snapshot.data;
                        
                        if(activeBooking == null) {
                          return Center(
                            child: CustomText(
                              text: "No Active Trips",
                              size: 18,
                            ),
                          );
                        }
                        
                        else{
                          return CustomButton(
                            hPadding: 10,
                            vPadding: 10,
                            onTap: () {},
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/${activeBooking.name}.jpg',
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
                                              text: activeBooking.name,
                                              size: 16,
                                              fontWeight: FontWeight.bold,
                                            ),

                                            const HSizedBox(
                                              height: 5,
                                            ),

                                            CustomText(
                                              text: '${activeBooking.price}',
                                              fontWeight: FontWeight.w600,
                                              fontFamily: GoogleFonts.poppins().fontFamily,
                                              textColor: Colors.white30,
                                            ),

                                            const HSizedBox(
                                              height: 5,
                                            ),

                                            CustomText(
                                              text: activeBooking.address,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: GoogleFonts.poppins().fontFamily,
                                              textColor: Colors.white30,
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
                                                const CustomText(
                                                  text: 'reservationDate',
                                                  fontWeight: FontWeight.bold,
                                                ),

                                                const WSizedBox(
                                                  width: 20,
                                                ),

                                                const CustomText(
                                                  text: 'Time',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ],
                                            ),
                                            
                                            const HSizedBox(
                                              height: 10,
                                            ),

                                            const CustomText(
                                              text: 'Tap for details or cancellation!',
                                              textColor: Colors.white38,
                                            ),
                                          ],
                                        ),
                                        CustomText(
                                          text: '${activeBooking.price} EGP',
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
                                    color: Colors.green,
                                    child: const CustomText(
                                      text: 'ACTIVE',
                                      textColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                      return Text('error retrieving the data, please try again');
                    default:
                      return Text('Default');
                  }
                },
              ),
            ),

            const HSizedBox(
              height: 30,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: CustomText(
                text: 'Previous Trips',
                size: 16,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),

            const HSizedBox(
              height: 15,
            ),

            FutureBuilder(
              initialData: null,
              future: historyFuture,
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
                      return Text(snapshot.error.toString());
                    }
                    
                    else if(snapshot.hasData){
                      List previousBookings = [];
                      
                      if(previousBookings.isEmpty) {
                        return const Center(
                          child: CustomText(
                            text: 'No Previous Trips',
                            size: 18,
                          ),
                        );
                      }
                      
                      else{
                        return Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: previousBookings.length,
                            scrollDirection: Axis.vertical,
                            separatorBuilder: (context, index) {
                              return const HSizedBox(
                                height: 25,
                              );
                            },
                            itemBuilder: (context, index) {
                              return CustomButton(
                                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                                hPadding: 10,
                                vPadding: 10,
                                onTap: () {},
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/discount.png',
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
                                                  text: '${previousBookings[index].schoolName}',
                                                  size: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),

                                                const HSizedBox(
                                                  height: 5,
                                                ),

                                                CustomText(
                                                  text: previousBookings[index].field,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                                  textColor: Colors.black.withOpacity(0.5),
                                                ),

                                                const HSizedBox(
                                                  height: 5,
                                                ),

                                                CustomText(
                                                  text: 'Fifth Settlement',
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                                  textColor: Colors.black.withOpacity(0.5),
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
                                                    const CustomText(
                                                      text: "Date",
                                                      fontWeight: FontWeight.bold,
                                                    ),

                                                    const WSizedBox(
                                                      width: 20,
                                                    ),

                                                    CustomText(
                                                      text: "Time",
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ],
                                                ),
                                                
                                                const HSizedBox(
                                                  height: 10,
                                                ),

                                                CustomText(
                                                  text: 'Tap For Details',
                                                  textColor: Colors.grey,
                                                ),
                                              ],
                                            ),
                                            CustomText(
                                              text: '${previousBookings[index].price} EGP',
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
                                        color: Colors.green,
                                        child: CustomText(
                                          text: "Cancelled",
                                          textColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
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
          ],
        ),
      ),
    );
  }
}
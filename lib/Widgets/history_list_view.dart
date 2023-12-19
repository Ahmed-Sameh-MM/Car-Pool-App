import 'package:flutter/material.dart';

import 'package:car_pool_app/Model%20Classes/history_helper.dart';
import 'package:car_pool_app/Screens/tracking_screen.dart';
import 'package:car_pool_app/Services/general_functions.dart';
import 'package:car_pool_app/Widgets/custom_button.dart';
import 'package:car_pool_app/Widgets/custom_container.dart';
import 'package:car_pool_app/Widgets/custom_text.dart';
import 'package:car_pool_app/Widgets/sized_box.dart';
import 'package:car_pool_app/Model%20Classes/trip.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryListView extends StatelessWidget {
  const HistoryListView({
    super.key,
    required this.helper,
  });

  final HistoryHelper helper;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: CustomText(
            text: helper.titleText,
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
            future: helper.future,
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
                    List<Trip> trips = [];
  
                    for(int i = 0; i < snapshot.data.length; i++) {
                      if(snapshot.data[i].status == helper.status) {
                        trips.add(snapshot.data[i]);
                      }
                    }
  
                    if(trips.isEmpty) {
                      return Center(
                        child: CustomText(
                          text: helper.emptyText,
                          size: 18,
                        ),
                      );
                    }
                    
                    else{
                      return SizedBox(
                        height: trips.length >= 2 ? 350 : 180,
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
                            return CustomButton(
                              hPadding: 10,
                              vPadding: 10,
                              onTap: () {
                              Navigator.pushNamed(context, TrackingScreen.routeName, arguments: trips[index]);
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
                      
                                              CustomText(
                                                text: helper.tapText,
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
                                      color: helper.typeColor,
                                      child: CustomText(
                                        text: helper.typeText,
                                        textColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
    );
  }
}
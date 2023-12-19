import 'package:flutter/material.dart';

import 'package:driver_car_pool_app/Widgets/sized_box.dart';
import 'package:driver_car_pool_app/Model%20Classes/trip.dart';
import 'package:driver_car_pool_app/Offline%20Storage/storage.dart';
import 'package:driver_car_pool_app/Services/realtime_db.dart';
import 'package:driver_car_pool_app/Widgets/history_list_view.dart';
import 'package:driver_car_pool_app/Model%20Classes/history_helper.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({ super.key });

  static const routeName = '/history';

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  Future? historyFuture;

  Future< List<Trip> > initHistory() async {
    final driver = await DriverStorage.readDriver();

    final temp = await Realtime(uid: driver.uid).getTrips();

    return temp.fold(
      (error) {
        return Future< List<Trip> >.error(error);
      },
      (trips) {
        return Future< List<Trip> >.value(trips);
      },
    );
  }

  void refreshHistory() {
    setState(() {
      historyFuture = initHistory();
    });
  }

  @override
  void initState() {
    historyFuture = initHistory();
    
    super.initState();
  }

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              HistoryListView(
                helper: HistoryHelper(
                  future: historyFuture,
                  titleText: "Open Trips",
                  status: TripStatus.open,
                  emptyText: "No Open Trips yet",
                  tapText: "Tap for details or cancellation!",
                  typeColor: Colors.grey,
                  typeText: "OPEN",
                  refreshFuture: refreshHistory,
                ),
              ),
        
              const HSizedBox(
                height: 40,
              ),
        
              HistoryListView(
                helper: HistoryHelper(
                  future: historyFuture,
                  titleText: "Fully Reserved Trips",
                  status: TripStatus.fullyReserved,
                  emptyText: "No Previous Fully Reserved Trips",
                  typeText: "FULLY RESERVED",
                  refreshFuture: refreshHistory,
                ),
              ),

              const HSizedBox(
                height: 40,
              ),
        
              HistoryListView(
                helper: HistoryHelper(
                  future: historyFuture,
                  titleText: "Completed Trips",
                  status: TripStatus.completed,
                  emptyText: "No Previous Completed Trips",
                  typeText: "COMPLETED",
                  refreshFuture: refreshHistory,
                ),
              ),

              const HSizedBox(
                height: 40,
              ),
        
              HistoryListView(
                helper: HistoryHelper(
                  future: historyFuture,
                  titleText: "Canceled Trips",
                  status: TripStatus.canceled,
                  emptyText: "No Previous Canceled Trips",
                  typeColor: Colors.grey,
                  typeText: "CANCELED",
                  refreshFuture: refreshHistory,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
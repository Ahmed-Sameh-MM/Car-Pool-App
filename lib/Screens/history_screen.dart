import 'package:flutter/material.dart';

import 'package:car_pool_app/Widgets/sized_box.dart';
import 'package:car_pool_app/Model%20Classes/trip.dart';
import 'package:car_pool_app/Offline%20Storage/storage.dart';
import 'package:car_pool_app/Services/realtime_db.dart';
import 'package:car_pool_app/Widgets/history_list_view.dart';
import 'package:car_pool_app/Model%20Classes/history_helper.dart';
import 'package:car_pool_app/Model%20Classes/driver_trip.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({ super.key });

  static const routeName = '/history';

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  Future? historyFuture;

  Future< List<DriverTrip> > initHistory() async {
    final user = await UserStorage.readUser();

    final temp = await Realtime(uid: user.uid).getTrips();

    return temp.fold(
      (error) {
        return Future< List<DriverTrip> >.error(error);
      },
      (driverTrips) {
        return Future< List<DriverTrip> >.value(driverTrips);
      },
    );
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
                  titleText: "Pending Trips",
                  status: TripStatus.pending,
                  emptyText: "No Pending Trips",
                  tapText: "Tap for details or cancellation!",
                  typeColor: Colors.grey,
                  typeText: "PENDING",
                ),
              ),
        
              const HSizedBox(
                height: 40,
              ),
        
              HistoryListView(
                helper: HistoryHelper(
                  future: historyFuture,
                  titleText: "Approved Trips",
                  status: TripStatus.approved,
                  emptyText: "No Previous Approved Trips",
                  typeText: "APPROVED",
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
                ),
              ),

              const HSizedBox(
                height: 40,
              ),
        
              HistoryListView(
                helper: HistoryHelper(
                  future: historyFuture,
                  titleText: "Rejected Trips",
                  status: TripStatus.rejected,
                  emptyText: "No Previous Rejected Trips",
                  typeColor: Colors.red,
                  typeText: "REJECTED",
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'package:car_pool_app/Widgets/sized_box.dart';
import 'package:car_pool_app/Model%20Classes/trip.dart';
import 'package:car_pool_app/Offline%20Storage/storage.dart';
import 'package:car_pool_app/Services/realtime_db.dart';
import 'package:car_pool_app/Widgets/history_list_view.dart';
import 'package:car_pool_app/Model%20Classes/history_helper.dart';
import 'package:car_pool_app/Model%20Classes/order.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({ super.key });

  static const routeName = '/history';

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  Future? historyFuture;

  Future< List<Trip> > initHistory() async {
    final user = await UserStorage.readUser();

    final temp = await Realtime(uid: user.uid).getTrips();

    return temp.fold(
      (error) {
        return Future< List<Trip> >.error(error);
      },
      (driverTrips) {
        return Future< List<Trip> >.value(driverTrips);
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
                  titleText: "Pending Trips",
                  status: OrderStatus.pending,
                  emptyText: "No Pending Trips",
                  tapText: "Tap for details or cancellation!",
                  typeColor: Colors.grey,
                  typeText: "PENDING",
                  refreshFuture: refreshHistory,
                ),
              ),
        
              const HSizedBox(
                height: 40,
              ),
        
              HistoryListView(
                helper: HistoryHelper(
                  future: historyFuture,
                  titleText: "Approved Trips",
                  status: OrderStatus.approved,
                  emptyText: "No Previous Approved Trips",
                  typeText: "APPROVED",
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
                  status: OrderStatus.completed,
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
                  titleText: "Rejected Trips",
                  status: OrderStatus.rejected,
                  emptyText: "No Previous Rejected Trips",
                  typeColor: Colors.red,
                  typeText: "REJECTED",
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
                  status: OrderStatus.canceled,
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
import 'package:flutter/material.dart';

import 'package:driver_car_pool_app/Model%20Classes/driver.dart';
import 'package:driver_car_pool_app/Offline%20Storage/storage.dart';
import 'package:driver_car_pool_app/Widgets/custom_text.dart';
import 'package:driver_car_pool_app/Widgets/profile_column.dart';
import 'package:driver_car_pool_app/Services/errors.dart';
import 'package:driver_car_pool_app/Services/realtime_db.dart';

import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ super.key });

  static const routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late Future<Driver> driverFuture;

  Future<Driver> initProfile() async {
    final driverDataFuture = await Realtime(uid: FirebaseAuth.instance.currentUser!.uid).getDriverData();

    return driverDataFuture.fold(
      (error) async {
        final driver = await DriverStorage.readDriver();

        // return the old driver data stored in the sqlite DB
        return Future<Driver>.value(driver);
      },
      
      (driverData) async {
        await DriverStorage.addDriver(driverData);
        final driver = await DriverStorage.readDriver();

        // return the new driver data stored in the sqlite DB
        return Future<Driver>.value(driver);
      },
    );
  }

  @override
  void initState() {
    driverFuture = initProfile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),

      body: FutureBuilder(
        initialData: null,
        future: driverFuture,
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
              return const CustomText(
                text: 'None',
                size: 30,
              );
    
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ); 
    
            case ConnectionState.done:
              if(snapshot.hasError) {
                final error = snapshot.error as ErrorTypes;
                
                return Center(
                  child: CustomText(
                    text: error.errorMessage,
                    size: 18,
                  ),
                );
              }
    
              else if(snapshot.hasData) {
                return ProfileColumn(
                  driver: snapshot.data as Driver,
                );
              }
    
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
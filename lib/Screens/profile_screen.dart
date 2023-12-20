import 'package:flutter/material.dart';

import 'package:car_pool_app/Model Classes/user.dart';
import 'package:car_pool_app/Offline%20Storage/storage.dart';
import 'package:car_pool_app/Widgets/custom_text.dart';
import 'package:car_pool_app/Widgets/profile_column.dart';
import 'package:car_pool_app/Services/realtime_db.dart';
import 'package:car_pool_app/Services/errors.dart';

import 'package:firebase_auth/firebase_auth.dart' as auth;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ super.key });

  static const routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late Future<User> userFuture;

  Future<User> initProfile() async {
    final driverDataFuture = await Realtime(uid: auth.FirebaseAuth.instance.currentUser!.uid).getUserData();

    return driverDataFuture.fold(
      (error) async {
        final user = await UserStorage.readUser();

        // return the old user data stored in the sqlite DB
        return Future<User>.value(user);
      },
      
      (userData) async {
        await UserStorage.addUser(userData);
        final user = await UserStorage.readUser();

        // return the new user data stored in the sqlite DB
        return Future<User>.value(user);
      },
    );
  }

  @override
  void initState() {
    userFuture = initProfile();

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
        future: userFuture,
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
                  user: snapshot.data as User,
                );
              }
    
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
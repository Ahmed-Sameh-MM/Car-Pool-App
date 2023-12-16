import 'package:flutter/material.dart';

import 'package:driver_car_pool_app/Model Classes/user.dart';
import 'package:driver_car_pool_app/Offline%20Storage/storage.dart';
import 'package:driver_car_pool_app/Widgets/custom_text.dart';
import 'package:driver_car_pool_app/Widgets/profile_column.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ super.key });

  static const routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late Future<User> userFuture;

  @override
  void initState() {
    userFuture = UserStorage.readUser();

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
              return const CircularProgressIndicator(
                strokeWidth: 2,
              ); 
    
            case ConnectionState.done:
              if(snapshot.hasError) {
                return CustomText(
                  text: '${snapshot.error}',
                  size: 30,
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
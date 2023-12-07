import 'package:flutter/material.dart';

import 'package:car_pool_app/Screens/main_screen.dart';
import 'package:car_pool_app/interface.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User?>(context);
    
    if(user == null) return const Interface();
    
    return const MainScreen();
  }
}
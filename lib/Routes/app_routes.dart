import 'package:flutter/material.dart';

import 'package:car_pool_app/Widgets/wrapper.dart';
import 'package:car_pool_app/Screens/main_screen.dart';
import 'package:car_pool_app/Screens/register_screen.dart';
import 'package:car_pool_app/Screens/login_screen.dart';
import 'package:car_pool_app/Screens/checkout_screen.dart';
import 'package:car_pool_app/Screens/home_screen.dart';
import 'package:car_pool_app/Model%20Classes/location.dart';
import 'package:car_pool_app/Screens/chosen_location_screen.dart';

class AppRoutes {

  // application routes

  static final Map<String, WidgetBuilder> routes = {
    '/': (_) => const Wrapper(),
    MainScreen.routeName: (_) => const MainScreen(),
    RegisterScreen.routeName: (_) => const RegisterScreen(),
    LoginScreen.routeName: (_) => const LoginScreen(),
    HomeScreen.routeName: (_) => const HomeScreen(),
    CheckoutScreen.routeName: (_) => const CheckoutScreen(),
  };

  // onGenerate routes
  static Route? onGenerateRoutes(RouteSettings settings) {
    if(settings.name == ChosenLocationScreen.routeName) {
      final args = settings.arguments as Location;

      return MaterialPageRoute(
        builder: (context) {
          return ChosenLocationScreen(
            generalLocationData: args,
          );
        },
      );
    }

    return null;
  }
}
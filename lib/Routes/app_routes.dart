import 'package:car_pool_app/Screens/history_screen.dart';
import 'package:flutter/material.dart';

import 'package:car_pool_app/Widgets/wrapper.dart';
import 'package:car_pool_app/Screens/main_screen.dart';
import 'package:car_pool_app/Screens/register_screen.dart';
import 'package:car_pool_app/Screens/login_screen.dart';
import 'package:car_pool_app/Screens/checkout_screen.dart';
import 'package:car_pool_app/Screens/locations_screen.dart';
import 'package:car_pool_app/Model%20Classes/location.dart';
import 'package:car_pool_app/Screens/chosen_location_screen.dart';
import 'package:car_pool_app/Screens/path_screen.dart';
import 'package:car_pool_app/Screens/gates_screen.dart';
import 'package:car_pool_app/Screens/payment_screen.dart';

class AppRoutes {

  // application routes

  static final Map<String, WidgetBuilder> routes = {
    '/': (_) => const Wrapper(),
    MainScreen.routeName: (_) => const MainScreen(),
    RegisterScreen.routeName: (_) => const RegisterScreen(),
    LoginScreen.routeName: (_) => const LoginScreen(),
    PathScreen.routeName: (_) => const PathScreen(),
    GatesScreen.routeName: (_) => const GatesScreen(),
    LocationsScreen.routeName: (_) => const LocationsScreen(),
    CheckoutScreen.routeName: (_) => const CheckoutScreen(),
    PaymentScreen.routeName: (_) => const PaymentScreen(),
    HistoryScreen.routeName: (_) => const HistoryScreen(),
  };

  // onGenerate routes
  static Route? onGenerateRoutes(RouteSettings settings) {
    if(settings.name == ChosenLocationScreen.routeName) {
      final args = settings.arguments as Location;

      return MaterialPageRoute(
        builder: (context) {
          return ChosenLocationScreen(
            locationData: args,
          );
        },
      );
    }

    return null;
  }
}
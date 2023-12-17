import 'package:flutter/material.dart';

import 'package:car_pool_app/Widgets/wrapper.dart';
import 'package:car_pool_app/Screens/main_screen.dart';
import 'package:car_pool_app/Screens/register_screen.dart';
import 'package:car_pool_app/Screens/login_screen.dart';
import 'package:car_pool_app/Screens/checkout_screen.dart';
import 'package:car_pool_app/Screens/routes_screen.dart';
import 'package:car_pool_app/Screens/chosen_route_screen.dart';
import 'package:car_pool_app/Screens/path_screen.dart';
import 'package:car_pool_app/Screens/gates_screen.dart';
import 'package:car_pool_app/Screens/payment_screen.dart';
import 'package:car_pool_app/Screens/history_screen.dart';
import 'package:car_pool_app/Screens/profile_screen.dart';
import 'package:car_pool_app/Screens/tracking_screen.dart';
import 'package:car_pool_app/Model%20Classes/custom_route.dart';
import 'package:car_pool_app/Model%20Classes/trip.dart';
import 'package:car_pool_app/Screens/trips_screen.dart';

class AppRoutes {

  // application routes

  static final Map<String, WidgetBuilder> routes = {
    '/': (_) => const Wrapper(),
    MainScreen.routeName: (_) => const MainScreen(),
    RegisterScreen.routeName: (_) => const RegisterScreen(),
    LoginScreen.routeName: (_) => const LoginScreen(),
    PathScreen.routeName: (_) => const PathScreen(),
    GatesScreen.routeName: (_) => const GatesScreen(),
    RoutesScreen.routeName: (_) => const RoutesScreen(),
    CheckoutScreen.routeName: (_) => const CheckoutScreen(),
    PaymentScreen.routeName: (_) => const PaymentScreen(),
    HistoryScreen.routeName: (_) => const HistoryScreen(),
    ProfileScreen.routeName: (_) => const ProfileScreen(),
  };

  // onGenerate routes
  static Route? onGenerateRoutes(RouteSettings settings) {
    if(settings.name == ChosenRouteScreen.routeName) {
      final args = settings.arguments as CustomRoute;

      return MaterialPageRoute(
        builder: (context) {
          return ChosenRouteScreen(
            routeData: args,
          );
        },
      );
    }

    else if(settings.name == TrackingScreen.routeName) {
      final args = settings.arguments as Trip;

      return MaterialPageRoute(
        builder: (context) {
          return TrackingScreen(
            trip: args,
          );
        },
      );
    }

    else if(settings.name == TripsScreen.routeName) {
      final args = settings.arguments as Trip;

      return MaterialPageRoute(
        builder: (context) {
          return TripsScreen(
            trip: args,
          );
        },
      );
    }

    return null;
  }
}
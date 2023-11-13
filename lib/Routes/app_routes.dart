import 'package:flutter/material.dart';

import 'package:car_pool_app/Widgets/wrapper.dart';
import 'package:car_pool_app/Screens/home_screen.dart';
import 'package:car_pool_app/Screens/login_screen.dart';

class AppRoutes {

  // application routes

  static final Map<String, WidgetBuilder> routes = {
    '/': (_) => const Wrapper(),
    HomeScreen.routeName: (_) => const HomeScreen(),
    LoginScreen.routeName: (_) => LoginScreen(),
  };

  // onGenerate routes
  static Route? onGenerateRoutes(RouteSettings settings) {
    // if(settings.name == SomeWidget.routeName) {
    //   final args = settings.arguments as Class;

    //   return MaterialPageRoute(
    //     builder: (context) {
    //       return SomeWidget(
    //         selectedBook: args,
    //       );
    //     },
    //   );
    // }

    return null;
  }
}
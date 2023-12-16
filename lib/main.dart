import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:driver_car_pool_app/Routes/app_routes.dart';
import 'package:driver_car_pool_app/firebase_options.dart';
import 'package:driver_car_pool_app/Services/authenticate.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ])
  .then((value) => runApp(
    const riverpod.ProviderScope(
      child: MainApp(),
    ),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider.value(
          initialData: null,
          value: userStream,
        )
      ],
      child: MaterialApp(
        routes: AppRoutes.routes,
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        theme: ThemeData(
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
          ),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

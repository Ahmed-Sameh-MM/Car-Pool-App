import 'package:car_pool_app/Model%20Classes/custom_route.dart';
import 'package:car_pool_app/Static%20Data/constants.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';


final routeTypeProvider = StateProvider<RouteType>((ref) => RouteType.none);

final chosenRouteProvider = StateProvider<CustomRoute>((ref) => CustomRoute.empty());
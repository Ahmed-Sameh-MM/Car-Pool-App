import 'package:car_pool_app/Model%20Classes/driver_trip.dart';
import 'package:car_pool_app/Services/lookup.dart';
import 'package:car_pool_app/Services/errors.dart';
import 'package:car_pool_app/Model%20Classes/custom_route.dart';
import 'package:car_pool_app/Model%20Classes/user.dart';
import 'package:car_pool_app/Model%20Classes/trip.dart';
import 'package:car_pool_app/Static%20Data/constants.dart';
import 'package:car_pool_app/Services/general_functions.dart';

import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';


final tripsReference = FirebaseDatabase.instance.ref("trips");

final driverTripsReference = FirebaseDatabase.instance.ref("driver_trips");

final routesReference = FirebaseDatabase.instance.ref("routes");

final rootReference = FirebaseDatabase.instance.ref();

class Realtime {

  final String uid;

  Realtime({
    required this.uid,
  });

  final usersReference = FirebaseDatabase.instance.ref("users");

  final driversReference = FirebaseDatabase.instance.ref("drivers");

  // Trip Reservation Methods
  
  Future< Either<ErrorTypes, bool> > reserveTrip({required Trip trip}) async {

    final connection = await LookUp.checkInternetConnection();

    return connection.fold(
      (error) {
        return Left(error);
      },
      (right) async {
        try {
          final disableValidation = await rootReference.child('disable_user_validation').once().then((event) => event.snapshot.value as bool);

          if(! disableValidation) {
            // checking the time constraints
            DateTime rawDate = DateTime(trip.tripDate.year, trip.tripDate.month, trip.tripDate.day);

            rawDate = rawDate.add(timeConstraints[durationToTime(trip.time)]!);

            if(trip.currentDate.isAfter(rawDate)) {
              return Left(
                LateReservationError(
                  errorMessage: "You need to reserve this time slot before ${durationToTime(timeConstraints[durationToTime(trip.time)]!)}",
                ),
              );
            }
          }

          // reserving successfully
          await tripsReference.child(uid).child(trip.id).set(trip.toJson());

          // adding the trip to the closed trips
          // await usersReference.child(uid).update({'reservedTrips': trip.tripDate});

          // Updating the users reference

          Map<String, dynamic> temp = {
            'numberOfSeats' : ServerValue.increment(-1),
            'users' : uid,
          };

          await driverTripsReference.child(uid).child(trip.id).update(temp); // TODO driver UID
          
          return const Right(true);
        }
        catch(e) {
          return Left(
            FirebaseError(
              errorMessage: 'Server Error: $e',
              errorId: 101,
            ),
          );
        }
      },
    );
  }

  Future< Either<ErrorTypes, bool> > cancelTrip({required String tripId}) async {

    final connection = await LookUp.checkInternetConnection();

    return connection.fold(
      (error) {
        return Left(error);
      },
      (right) async {
        try {
          // canceling successfully
          await tripsReference.child(uid).child(tripId).update({'status': 'canceled'});
          
          return const Right(true);
        }
        catch(e) {
          return Left(
            FirebaseError(
              errorMessage: 'Server Error: $e',
              errorId: 101,
            ),
          );
        }
      },
    );
  }

  Future< Either<ErrorTypes, List<Trip>> > getTrips() async {
    final connection = await LookUp.checkInternetConnection();
    return connection.fold(
      (error) {
        return Left(error);
      },
      (right) async {
        try {
          final trips = await tripsReference.child(uid).once().then((event) {
            Map jsonMap = (event.snapshot.value ?? {}) as Map;

            final List<Trip> temp = [];

            jsonMap.forEach((key, value) {
              temp.add(Trip.fromJson(value));
            });
            
            return temp;
          });

          return Right(trips);
        }
        catch(e) {
          return Left(
            FirebaseError(
              errorMessage: 'Server Error: $e',
              errorId: 103,
            ),
          );
        }
      },
    );
  }

  Future< Either<ErrorTypes, List<DriverTrip>> > filterDriverTrips({required Trip trip}) async {
    final connection = await LookUp.checkInternetConnection();
    return connection.fold(
      (error) {
        return Left(error);
      },
      (right) async {
        try {
          final trips = await driverTripsReference.once().then((event) {
            Map jsonMap = (event.snapshot.value ?? {}) as Map;

            final List<DriverTrip> driverTrips = [];

            jsonMap.forEach((key, value) {
              Map tripsMap = (value ?? {}) as Map;

              tripsMap.forEach((tripId, trip) {
                final driverTrip = DriverTrip.fromJson(trip);
                driverTrip.driverUid = key;
                
                driverTrips.add(trip);
              });
            });

            driverTrips.removeWhere((element) {
              return element.source != trip.source || element.destination != trip.destination || ! element.tripDate.isAtSameMomentAs(trip.tripDate) || element.time.compareTo(trip.time) != 0;
            });
            
            return driverTrips;
          });

          return Right(trips);
        }
        catch(e) {
          return Left(
            FirebaseError(
              errorMessage: 'Server Error: $e',
              errorId: 103,
            ),
          );
        }
      },
    );
  }

  // End of Trip Reservation methods

  // UserData Methods

  Future< Either<ErrorTypes, bool> > addUserData(User user) async {
    final connection = await LookUp.checkInternetConnection();
    return connection.fold(
      (error) {
        return Left(error);
      },
      (right) async {
        try {
          await usersReference.child(uid).set(user.toJson());
          return const Right(true);
        }
        catch(e) {
          return Left(
            FirebaseError(
              errorMessage: 'Server Error: $e',
              errorId: 103,
            ),
          );
        }
      },
    );
  }

  Future< Either<ErrorTypes, User> > getUserData() async {
    final connection = await LookUp.checkInternetConnection();
    return connection.fold(
      (error) {
        return Left(error);
      },
      (right) async {
        try {
          final user = await usersReference.child(uid).once().then((event) => User.fromJson(event.snapshot.value as Map));
          return Right(user);
        }
        catch(e) {
          return Left(
            FirebaseError(
              errorMessage: 'Server Error: $e',
              errorId: 103,
            ),
          );
        }
      },
    );
  }

  // End of UserData methods
}

// Switch Value Methods

Future< Either<ErrorTypes, bool> > getSwitchValue() async {
  final connection = await LookUp.checkInternetConnection();

  return connection.fold(
    (error) {
      return Left(error);
    },
    (right) async {
      try {
        final disableValidation = await rootReference.child('disable_user_validation').once().then((event) => event.snapshot.value as bool);
        
        return Right(disableValidation);
      }
      catch(e) {
        return Left(
          FirebaseError(
            errorMessage: 'Server Error: $e',
            errorId: 101,
          ),
        );
      }
    },
  );
}

Future< Either<ErrorTypes, bool> > setSwitchValue(bool value) async {
    final connection = await LookUp.checkInternetConnection();

    return connection.fold(
      (error) {
        return Left(error);
      },
      (right) async {
        try {
          await rootReference.child('disable_user_validation').set(value);
          
          return const Right(true);
        }
        catch(e) {
          return Left(
            FirebaseError(
              errorMessage: 'Server Error: $e',
              errorId: 101,
            ),
          );
        }
      },
    );
  }

  // CustomRoute Methods

  Future< Either<ErrorTypes, List<CustomRoute>> > getRoutes() async {
    final connection = await LookUp.checkInternetConnection();
    return connection.fold(
      (error) {
        return Left(error);
      },
      (right) async {
        try {
          final routes = await routesReference.once().then((event) {
            final List jsonList = event.snapshot.value as List;
            
            return List<CustomRoute>.from(jsonList.map((route) => CustomRoute.fromJson(route.cast<String, dynamic>())));
          });

          return Right(routes);
        }
        catch(e) {
          return Left(
            FirebaseError(
              errorMessage: 'Server Error: $e',
              errorId: 103,
            ),
          );
        }
      },
    );
  }

Stream<DatabaseEvent> dayStream(String schoolId, String day) {
  return tripsReference.child(schoolId).child(day).onValue;
}
import 'package:driver_car_pool_app/Services/date.dart';
import 'package:driver_car_pool_app/Services/lookup.dart';
import 'package:driver_car_pool_app/Services/errors.dart';
import 'package:driver_car_pool_app/Model%20Classes/custom_route.dart';
import 'package:driver_car_pool_app/Model%20Classes/driver.dart';
import 'package:driver_car_pool_app/Model%20Classes/trip.dart';
import 'package:driver_car_pool_app/Static%20Data/constants.dart';
import 'package:driver_car_pool_app/Services/general_functions.dart';

import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';


final driverTripsReference = FirebaseDatabase.instance.ref("driver_trips");

final userTripsReference = FirebaseDatabase.instance.ref("trips");

final routesReference = FirebaseDatabase.instance.ref("routes");

final usersReference = FirebaseDatabase.instance.ref("users");

class Realtime {

  final String uid;

  Realtime({
    required this.uid,
  });

  final driversReference = FirebaseDatabase.instance.ref("drivers");

  // Trip Reservation Methods
  
  Future< Either<ErrorTypes, bool> > createTrip({required Trip trip}) async {

    final check = await checkTrip(trip: trip);

    return check.fold(
      (error) {
        return Left(error);
      },
      (right) async {
        try {
          final disableValidation = await FirebaseDatabase.instance.ref().child('disable_driver_validation').once().then((event) => event.snapshot.value as bool);

          if(! disableValidation) {
            // checking the time constraints
            DateTime rawDate = DateTime(trip.tripDate.year, trip.tripDate.month, trip.tripDate.day);

            rawDate = rawDate.add(timeConstraints[durationToTime(trip.time)]!);

            if(trip.currentDate.isAfter(rawDate)) {
              return Left(
                LateReservationError(
                  errorMessage: "You need to create this trip before ${timeConstraintsErrorMessages[trip.time]!}",
                ),
              );
            }
          }

          // reserving successfully
          await driverTripsReference.child(uid).child(trip.id).set(trip.toJson());
          
          return const Right(true);
        }
        catch(e) {
          return Left(
            FirebaseError(
              errorMessage: 'Server Error: $e',
              errorId: 100,
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
          // cancelling successfully
          await driverTripsReference.child(uid).child(tripId).update({'tripStatus': 'canceled'});

          // rejecting the users trips

          final users = await driverTripsReference.child(uid).child(tripId).child("users").once().then((event) => event.snapshot.value);

          final usersList = List<String>.from((users ?? []) as List);

          for(int i = 0; i < usersList.length; i++) {
            await userTripsReference.child(usersList[i]).child(tripId).update({"status": "rejected"});
          }
          
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

  Future< Either<ErrorTypes, bool> > approveTrip({required Trip trip}) async {

    final connection = await LookUp.checkInternetConnection();

    return connection.fold(
      (error) {
        return Left(error);
      },
      (right) async {
        try {
          final disableApproval = await FirebaseDatabase.instance.ref().child('disable_approval_driver').once().then((event) => event.snapshot.value as bool);

          if(! disableApproval) {
            // checking the time constraints
            DateTime rawDate = DateTime(trip.tripDate.year, trip.tripDate.month, trip.tripDate.day);

            rawDate = rawDate.add(approvalTimeConstraints[durationToTime(trip.time)]!);

            final currentDateFuture = await Date.fetchDate();

            return currentDateFuture.fold(
              (error) {
                return Left(error);
              },
              (currentDate) async {
                if(currentDate.isAfter(rawDate)) {
                  await cancelTrip(
                    tripId: trip.id,
                  );
                  
                  return Left(
                    LateApprovalError(
                      errorMessage: "You need to approve this trip before ${approvalErrorMessages[trip.time]!}",
                    ),
                  );
                }

                // approving successfully
                await driverTripsReference.child(uid).child(trip.id).update({'tripStatus': 'approved'});

                // approving the users trips

                final users = await driverTripsReference.child(uid).child(trip.id).child("users").once().then((event) => event.snapshot.value);

                final usersList = List<String>.from((users ?? []) as List);

                for(int i = 0; i < usersList.length; i++) {
                  await userTripsReference.child(usersList[i]).child(trip.id).update({"status": "approved"});
                }
                
                return const Right(true);
              },
            );
          }

          // approving successfully
          await driverTripsReference.child(uid).child(trip.id).update({'tripStatus': 'approved'});

          // approving the users trips

          final users = await driverTripsReference.child(uid).child(trip.id).child("users").once().then((event) => event.snapshot.value);

          final usersList = List<String>.from((users ?? []) as List);

          for(int i = 0; i < usersList.length; i++) {
            await userTripsReference.child(usersList[i]).child(trip.id).update({"status": "approved"});
          }
          
          return const Right(true);
        }
        catch(e) {
          return Left(
            FirebaseError(
              errorMessage: 'Server Error: $e',
              errorId: 102,
            ),
          );
        }
      },
    );
  }

  Future< Either<ErrorTypes, bool> > completeTrip({required String tripId}) async {

    Map<String, dynamic> temp = {
      'tripsCount' : ServerValue.increment(1),
      'points' : ServerValue.increment(5),
    };

    final connection = await LookUp.checkInternetConnection();

    return connection.fold(
      (error) {
        return Left(error);
      },
      (right) async {
        try {
          // completing successfully
          await driverTripsReference.child(uid).child(tripId).update({'tripStatus': 'completed'});

          // giving bonus to the drivers
          await driversReference.child(uid).update(temp);


          final users = await driverTripsReference.child(uid).child(tripId).child("users").once().then((event) => event.snapshot.value);

          final usersList = List<String>.from((users ?? []) as List);

          for(int i = 0; i < usersList.length; i++) {
            // completing the users trips
            await userTripsReference.child(usersList[i]).child(tripId).update({"status": "completed"});

            // giving bonus to the users
            await usersReference.child(usersList[i]).update(temp);
          }
          
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

  Future< Either<ErrorTypes, List<Trip>> > getTrips() async {
    final connection = await LookUp.checkInternetConnection();
    return connection.fold(
      (error) {
        return Left(error);
      },
      (right) async {
        try {
          final trips = await driverTripsReference.child(uid).once().then((event) {
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
              errorId: 104,
            ),
          );
        }
      },
    );
  }

  Future< Either<ErrorTypes, bool> > checkTrip({required Trip trip}) async {
    
    final tripsFuture = await getTrips();

    return tripsFuture.fold(
      (error) {
        return Left(error);
      },
      (trips) {
        for(int i = 0; i < trips.length; i++) {
          if(trips[i].source == trip.source && trips[i].destination == trip.destination && trips[i].tripDate.isAtSameMomentAs(trip.tripDate) && trips[i].time.compareTo(trip.time) == 0) {
            return const Left(
              AlreadyReservedError()
            );
          }
        }

        return const Right(true);
      },
    );
  }

  // End of Trip Reservation methods

  // UserData Methods

  Future< Either<ErrorTypes, bool> > addDriverData(Driver driver) async {
    final connection = await LookUp.checkInternetConnection();
    return connection.fold(
      (error) {
        return Left(error);
      },
      (right) async {
        try {
          await driversReference.child(uid).set(driver.toJson());
          return const Right(true);
        }
        catch(e) {
          return Left(
            FirebaseError(
              errorMessage: 'Server Error: $e',
              errorId: 105,
            ),
          );
        }
      },
    );
  }

  Future< Either<ErrorTypes, Driver> > getDriverData() async {
    final connection = await LookUp.checkInternetConnection();
    return connection.fold(
      (error) {
        return Left(error);
      },
      (right) async {
        try {
          final user = await driversReference.child(uid).once().then((event) => Driver.fromJson(event.snapshot.value as Map));
          return Right(user);
        }
        catch(e) {
          return Left(
            FirebaseError(
              errorMessage: 'Server Error: $e',
              errorId: 106,
            ),
          );
        }
      },
    );
  }

  // End of UserData methods
}

// Switch Value Methods

Future< Either<ErrorTypes, bool> > getValidationSwitchValue() async {
  final connection = await LookUp.checkInternetConnection();

  return connection.fold(
    (error) {
      return Left(error);
    },
    (right) async {
      try {
        final disableValidation = await FirebaseDatabase.instance.ref().child('disable_driver_validation').once().then((event) => event.snapshot.value as bool);
        
        return Right(disableValidation);
      }
      catch(e) {
        return Left(
          FirebaseError(
            errorMessage: 'Server Error: $e',
            errorId: 107,
          ),
        );
      }
    },
  );
}

Future< Either<ErrorTypes, bool> > setValidationSwitchValue(bool value) async {
    final connection = await LookUp.checkInternetConnection();

    return connection.fold(
      (error) {
        return Left(error);
      },
      (right) async {
        try {
          await FirebaseDatabase.instance.ref().child('disable_driver_validation').set(value);
          
          return const Right(true);
        }
        catch(e) {
          return Left(
            FirebaseError(
              errorMessage: 'Server Error: $e',
              errorId: 108,
            ),
          );
        }
      },
    );
  }

  Future< Either<ErrorTypes, bool> > getApprovalSwitchValue() async {
  final connection = await LookUp.checkInternetConnection();

  return connection.fold(
    (error) {
      return Left(error);
    },
    (right) async {
      try {
        final disableValidation = await FirebaseDatabase.instance.ref().child('disable_approval_driver').once().then((event) => event.snapshot.value as bool);
        
        return Right(disableValidation);
      }
      catch(e) {
        return Left(
          FirebaseError(
            errorMessage: 'Server Error: $e',
            errorId: 117,
          ),
        );
      }
    },
  );
}

Future< Either<ErrorTypes, bool> > setApprovalSwitchValue(bool value) async {
    final connection = await LookUp.checkInternetConnection();

    return connection.fold(
      (error) {
        return Left(error);
      },
      (right) async {
        try {
          await FirebaseDatabase.instance.ref().child('disable_approval_driver').set(value);
          
          return const Right(true);
        }
        catch(e) {
          return Left(
            FirebaseError(
              errorMessage: 'Server Error: $e',
              errorId: 118,
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
              errorId: 109,
            ),
          );
        }
      },
    );
  }

Stream<DatabaseEvent> dayStream(String schoolId, String day) {
  return driverTripsReference.child(schoolId).child(day).onValue;
}
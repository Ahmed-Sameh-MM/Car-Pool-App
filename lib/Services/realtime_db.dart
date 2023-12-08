import 'package:flutter/material.dart'; // used for debugPrint()

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

final routesReference = FirebaseDatabase.instance.ref("routes");

class Realtime {

  final String uid;

  Realtime({
    required this.uid,
  });

  final usersReference = FirebaseDatabase.instance.ref("users");

  // Trip Reservation Methods
  
  Future< Either<ErrorTypes, bool> > reserve({required Trip trip}) async {

    final connection = await LookUp.checkInternetConnection();

    return connection.fold(
      (error) {
        return Left(error);
      },
      (right) async {
        try {
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

          // reserving successfully
          await tripsReference.child(uid).child(trip.id).set(trip.toJson());

          // Updating the users reference

          Map<String, dynamic> temp = {
            'tripsCount' : ServerValue.increment(1),
            'points' : ServerValue.increment(5),
          };

          await usersReference.child(uid).update(temp);
          
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
            final List jsonList = event.snapshot.value as List;
            
            return List<Trip>.from(jsonList.map((trip) => Trip.fromJson(trip.cast<String, dynamic>())));
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

  // CustomRoute Methods

  Future< Either<ErrorTypes, bool> > addRoutes(List<CustomRoute> routes) async {
    final connection = await LookUp.checkInternetConnection();
    return connection.fold(
      (error) {
        return Left(error);
      },
      (right) async {
        try {
          for(int i = 0; i < routes.length; i++) {
            await routesReference.child('$i').set(routes[i].toJson());
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

  Future< Either<ErrorTypes, String> > getEmailFromPhone() async {
    final connection = await LookUp.checkInternetConnection();

    return connection.fold(
      (error) {
        return Left(error);
      },
      (right) async {
        try{
          final String email = await usersReference.child(uid).child("email").once().then((event) {
            return event.snapshot.value as String;
          });
          return Right(email);
        }
        catch(e){
          debugPrint('getEmailFromPhone ERROR:  $e');
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

Stream<DatabaseEvent> dayStream(String schoolId, String day) {
  return tripsReference.child(schoolId).child(day).onValue;
}
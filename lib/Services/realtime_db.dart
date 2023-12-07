import 'dart:io';
import 'package:car_pool_app/Model%20Classes/trip.dart';
import 'package:flutter/material.dart'; // used for debugPrint()

import 'package:car_pool_app/Services/lookup.dart';
import 'package:car_pool_app/Services/errors.dart';
import 'package:car_pool_app/Services/date.dart';
import 'package:car_pool_app/Model%20Classes/custom_route.dart';
import 'package:car_pool_app/Model%20Classes/user.dart';

import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';


final reservationDataReference = FirebaseDatabase.instance.ref().child("/reservation_data");

final routesReference = FirebaseDatabase.instance.ref("routes");

class Realtime {

  final String uid;

  Realtime({
    required this.uid,
  });

  final usersReference = FirebaseDatabase.instance.ref().child("/users");

  // Reservation Methods
  
  Future< Either<ErrorTypes, bool> > reserve({required Trip trip}) async {

    final connection = await LookUp.checkInternetConnection();

    return connection.fold(
      (error) {
        return Left(error);
      },
      (right) async {
        try {
          // checking the time constraints
          // debugPrint(trip.date.add(trip.time));

          // reserving successfully
          await reservationDataReference.child(trip.date.toString()).child(trip.id.toString()).update({});

          // Updating the users reference

          Map<String, dynamic> temp_2 = {
            // 'accountStatus' : UserData.statusToString(AccountStatus.active),
            'tripsCount' : ServerValue.increment(1),
            'points' : ServerValue.increment(5),
          };

          await usersReference.child(uid).update(temp_2);
          
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

  // void removeReservationAndUserDataRecords(ReservationHistory reservationHistory) async {
  //   // Removing the corresponding reservation record from the DB
  //   Map<String, dynamic> chosenTimeSlots = {};
  //   for(int i = 0; i < reservationHistory.chosenTimeSlots.length; i++) {
  //     chosenTimeSlots['${reservationHistory.chosenTimeSlots[i]}'] = null;
  //   }
  //   await reservationDataReference.child(reservationHistory.schoolId).child(reservationHistory.day).child(reservationHistory.field).update(chosenTimeSlots);

  //   // Removing the corresponding userData record from the DB
  //   await userDataReference.child(reservationHistory.schoolId).child(reservationHistory.day).child(reservationHistory.field).child(reservationHistory.slots).remove();
  // }

  // Future< Either<ErrorTypes, UserData> > cancelReservation(ReservationHistory reservationHistory, int penaltyAmount) async {

  //   final connection = await LookUp.checkInternetConnection();

  //   return connection.fold(
  //     (error) {
  //       return Left(error);
  //     },
  //     (right) async {
  //       final currentDate = await Date.fetchDate();

  //       return currentDate.fold(
  //         (error) {
  //           return Left(error);
  //         },
  //         (currentDate) async {
  //           try {
  //             if(currentDate.difference(reservationHistory.reservationDate) >= const Duration()) {
  //               return Left(
  //                 ExpiredCancellation(),
  //               );
  //             }
              
  //             removeReservationAndUserDataRecords(reservationHistory);

  //             // Updating User Map (Universal Map)

  //             Map<String, dynamic> userMap = {
  //               'accountStatus' : UserData.statusToString(AccountStatus.inactive),
  //               'canceledReservations' : ServerValue.increment(1),
  //               'historyUpdateFlag' : ServerValue.increment(1),
  //               'penaltyAmount' : penaltyAmount,
  //             };

  //             // Penalty Checking
  //             final penalty = await penaltyReference.once();

  //             final penaltyMap = Map<String, dynamic>.from(penalty.snapshot.value as Map<String, dynamic>);

  //             final cancellationLimit = CustomDuration.limitToDuration(penaltyMap[Constants.cancellationLimit]);

  //             if(currentDate.difference(reservationHistory.reservationDate) > cancellationLimit) {
                
  //               String penaltyValue = Constants.firstPenalty;
  //               if(penaltyAmount > 0) {
  //                 penaltyValue = Constants.secondPenalty; // Applying the second penalty
  //                 userMap['accountStatus'] = UserData.statusToString(AccountStatus.locked); // Account lock
  //               }

  //               userMap['penaltyAmount'] = penaltyMap[penaltyValue] * reservationHistory.chosenTimeSlots.length;
  //             }

  //             // Updating the users reference

  //             await usersReference.child(uid).update(userMap);
              
  //             return Right(UserData.cancellation(
  //               accountStatus: UserData.stringToStatus(userMap['accountStatus']),
  //               penaltyAmount: userMap['penaltyAmount'],
  //             ));
  //           }
  //           catch(e){
  //             return Left(
  //               FirebaseError(
  //                 errorMessage: 'Server Error: $e',
  //                 errorId: 102,
  //               ),
  //             );
  //           }
  //         },
  //       );
  //     },
  //   );
  // }

  // End of Reservation methods

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
          List<CustomRoute> routes = [];

          final response = await routesReference.once().then((event) {
            final List jsonList = event.snapshot.value as List;
            
            routes = List<CustomRoute>.from(jsonList.map((route) => CustomRoute.fromJson(route.cast<String, dynamic>())));
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

  // Future< Either<ErrorTypes, UserData> > getUserData() async {

  //   final connection = await LookUp.checkInternetConnection();

  //   return connection.fold(
  //     (error) {
  //       return Left(error);
  //     },
  //     (right) async {
  //       try{
  //         final userData = await usersReference.child(uid).once().then((event) {

  //           final userDataMap = Map<String, dynamic>.from(event.snapshot.value as Map);

  //           return UserData(
  //             name: userDataMap['name'],
  //             phoneNumber: userDataMap['number'],
  //             email: userDataMap['email'],
  //             isEmailVerified: userDataMap['isEmailVerified'],
  //             points: userDataMap['points'],
  //             accountStatus: UserData.stringToStatus(userDataMap['accountStatus']),
  //             historyUpdateFlag: userDataMap['historyUpdateFlag'],
  //             reservationsCounter: userDataMap['reservationsCounter'],
  //             penaltyAmount: userDataMap['penaltyAmount'],
  //           );
  //         });
  //         return Right(userData);
  //       }
  //       catch(e){
  //         return Left(
  //           FirebaseError(
  //             errorMessage: 'Server Error: $e',
  //             errorId: 104,
  //           ),
  //         );
  //       }
  //     },
  //   );
  // }

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

  Future updateEmail(String email) async {
    try {
      await usersReference.child(uid).update({
        'email' : email,
      });
    }
    catch(e) {
      debugPrint('updateEmailError: $e');
    }    
  }
  
  // End of UserData methods

  // Penalty Methods

  // Future< Either<ErrorTypes, UserData> > autoCancellation(ReservationHistory reservationHistory, int penaltyAmount) async {

  //   final connection = await LookUp.checkInternetConnection();

  //   return connection.fold(
  //     (error) {
  //       return Left(error);
  //     },
  //     (right) async {
  //       final currentDate = await Date.fetchDate();

  //       return currentDate.fold(
  //         (error) {
  //           return Left(error);
  //         },
  //         (currentDate) async {
  //           try {
  //             final penalty = await penaltyReference.once();

  //             final penaltyMap = Map<String, dynamic>.from(penalty.snapshot.value as Map<String, dynamic>);

  //             final confirmationLimit = CustomDuration.limitToDuration(penaltyMap[Constants.confirmationLimit]);

  //             // Updating User Map (Universal Map)

  //             Map<String, dynamic> userMap = {
  //               'accountStatus' : UserData.statusToString(AccountStatus.active),
  //               'canceledReservations' : ServerValue.increment(1),
  //               'historyUpdateFlag' : ServerValue.increment(1),
  //               'penaltyAmount' : penaltyAmount,
  //             };

  //             if(currentDate.difference(reservationHistory.reservationDate) > confirmationLimit) {
  //               String penaltyValue = Constants.firstPenalty;
  //               userMap['accountStatus'] = UserData.statusToString(AccountStatus.inactive);

  //               if(penaltyAmount > 0) {
  //                 penaltyValue = Constants.secondPenalty; // Applying the second penalty
  //                 userMap['accountStatus'] = UserData.statusToString(AccountStatus.locked); // Account lock
  //               }

  //               userMap['penaltyAmount'] = penaltyMap[penaltyValue] * reservationHistory.chosenTimeSlots.length;

  //               removeReservationAndUserDataRecords(reservationHistory);

  //               // Updating the users reference
  //               await usersReference.child(uid).update(userMap);
  //             }

  //             return Right(UserData.cancellation(
  //               accountStatus: UserData.stringToStatus(userMap['accountStatus']),
  //               penaltyAmount: userMap['penaltyAmount'],
  //             ));
  //           }
  //           catch(e) {
  //             debugPrint('autoCancellation ERROR: $e');
  //             return Left(
  //               FirebaseError(
  //                 errorMessage: 'Server Error: $e',
  //                 errorId: 109,
  //               ),
  //             );
  //           }
  //         },
  //       );
  //     },
  //   );
  // }

  // End of Penalty methods
}

Stream<DatabaseEvent> dayStream(String schoolId, String day) {
  return reservationDataReference.child(schoolId).child(day).onValue;
}

Future< Either<ErrorTypes, Map<dynamic, dynamic>> > readGeneralFlags() async {
  final connection = await LookUp.checkInternetConnection();
  return connection.fold(
    (error) {
      return Left(error);
    },
    (right) async {
      try{
        late final Map<dynamic,dynamic> tempGeneralFlags;
        await routesReference.once().then((event) { 
          tempGeneralFlags = event.snapshot.value as Map;
        });
        debugPrint("readGeneralFlags -> $tempGeneralFlags");
        return Right(tempGeneralFlags);
      }
      on SocketException catch (e) {
        debugPrint("readGeneralFlags -> SOCKETEXCEPTION: $e");
        return const Left(
          ConnectionError(
            errorMessage: 'No Internet Connection, please try again',
          ),
        );
      }
      catch (e) {
        debugPrint("readGeneralFlags  : $e");
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

// Future< Either<ErrorTypes, int> > getCancellationLimit() async {

//   final connection = await LookUp.checkInternetConnection();

//   return connection.fold(
//     (error) {
//       return Left(error);
//     },
//     (right) async {
//       try{
//         final int cancellationLimit = await penaltyReference.child("cancellationLimit").once().then((event) {
//           return event.snapshot.value as int;
//         });
//         return Right(cancellationLimit);
//       }
//       catch(e){
//         return Left(
//           FirebaseError(
//             errorMessage: 'Server Error: $e',
//             errorId: 0,
//           ),
//         );
//       }
//     },
//   );
// }

Future< Either<ErrorTypes, Map<String, List>> > getSchool(String schoolName, String day) async {
  final connection = await LookUp.checkInternetConnection();

  return connection.fold(
    (error) {
      return Left(error);
    },
    
    (right) async {
      try {
        final DatabaseEvent temp = await reservationDataReference.child(schoolName).child(day).once();

        final temp_2 = Map<String, List>.from(temp.snapshot.value as Map);

        return Right(temp_2);
      }
      catch(e) {
        return Left(
          FirebaseError(
            errorMessage: 'Server Error: $e',
            errorId: 0,
          ),
        );
      }
    },
  );
}
import 'package:flutter/material.dart';

import 'package:car_pool_app/Services/lookup.dart';
import 'package:car_pool_app/Services/errors.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';

final auth = FirebaseAuth.instance;

Stream<User?> get userStream
{
  debugPrint('User Stream Triggered !!!!!');
  return auth.userChanges();
}

Future<void> signout() async
{
  try{
    return await auth.signOut();
  }
  catch(e){
    debugPrint(e.toString());
    debugPrint('error signing out!');
    return;
  }
}

Future< Either<ErrorTypes, User?> > registerWithEmail({required String email, required String password}) async
{
  final connection = await LookUp.checkInternetConnection();

  return connection.fold(
    (error) {
      return Left(error);
    },
    (success) async {
      try{
        final userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return Right(userCredential.user);
      }
      on FirebaseAuthException catch(e) {

        if(e.code == 'email-already-in-use'){
          debugPrint("email already in use!!");
        }
        else if(e.code == 'weak-password'){
          debugPrint("weak password....");
        }
        else if(e.code == "invalid-email"){
          debugPrint("invalid- Email... pls enter a valid one");
        }
        else if(e.code == 'operation-not-allowed'){
          debugPrint("operation not allowed, contact support !");
        }
        return Left(
          UnexpectedError(
            customError: e.code,
            errorId: 100,
          ),
        );
      }
      catch(e) {
        debugPrint("creating a new email failed!!");
        return Left(
          UnexpectedError(
            customError: e.toString(),
            errorId: 101,
          ),
        );
      }
    },
  );
}

Future< Either<ErrorTypes, bool> > loginWithEmail({required String email, required String password}) async
{

  final connection = await LookUp.checkInternetConnection();

  return connection.fold(
    (error) {
      return Left(error);
    },
    (right) async {
      try{
        /*UserCredential user = */await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        //return user.user;
        return const Right(true);
      }
      on FirebaseAuthException catch (e) {
        if(e.code == 'user-not-found')
        {
          debugPrint('No user found for that email.');
          return Left(
            UnexpectedError(
              customError: e.code,
              errorId: 400,
            ),
          );
        }
        else if(e.code == 'wrong-password')
        {
          return const Left(
            WrongPasswordError(),
          );
        }
        else if(e.code == 'invalid-email'){
          debugPrint('invalid email');
          return Left(
            UnexpectedError(
              customError: e.code,
              errorId: 401,
            ),
          );
        }
        else if(e.code == 'user-disabled'){
          return const Left(
            UserDisabledError(),
          );
        }
        return Left(
          UnexpectedError(
            customError: 'Unexpected FirebaseAuthException',
            errorId: 402,
          ),
        );
      }
      catch (e) {
        return Left(
          FirebaseError(
            errorMessage: 'Server Error: $e',
            errorId: 301,
          ),
        );
      }
    },
  );
}

Future<void> resetPassword(String email) async
{
  final connection = await LookUp.checkInternetConnection();

  connection.fold(
    (error) {
      return Left(error);
    },
    (right) {
      
    },
  );
  try{ // TODO error handling
    auth.sendPasswordResetEmail(
      email: email,
    );
  }
  catch(e){
    debugPrint('resetEmailError: $e');
  }
}

Future<String> verifyEmail() async {
  try {
    await auth.currentUser?.sendEmailVerification();
    return 'A verification Email has been sent successfully !';
  }
  on FirebaseAuthException catch(e) {
    debugPrint('verifyEmailError: $e');
    if(e.code == 'too-many-requests') return 'Too many Requests, Try again later !';
    return 'Error';
  }
}

// Future<void> finishedRegistration(RegistrationData registrationData, String password, BuildContext context) async
// {
//   debugPrint("START :::: ${getCurrentUser()}"); 
//   await emailUser.updateDisplayName(registrationData.fName +' '+ registrationData.lName); //TODO test to revoke any potential errors
  
//   await getCurrentUser()?.reload();
//   debugPrint("FINAL :::: ${getCurrentUser()}");
// }

User? getCurrentUser()
{
  return auth.currentUser;
}
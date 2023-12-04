import 'dart:io';
import 'package:flutter/material.dart';

import 'package:car_pool_app/Services/errors.dart';

import 'package:dartz/dartz.dart';

class LookUp {

  static Future< Either<ErrorTypes, bool> > checkInternetConnection() async {
    try{

      final result = await InternetAddress.lookup('www.google.com', type: InternetAddressType.IPv4);

      debugPrint(result.toString());
      debugPrint((result[0].address == '').toString());
      
      if(result.isNotEmpty && result[0].address != '') debugPrint('successful');
      return const Right(true);
    }
    on SocketException catch(e) {
      debugPrint('lookupERROR -> SocketException: $e');
      return const Left(
        ConnectionError(
          errorMessage: "No Internet Connection, please try again",
        ),
      );
    }
  }
}
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:driver_car_pool_app/Services/errors.dart';

import 'package:http/http.dart';
import 'package:dartz/dartz.dart';

class Date {
  static const Map<String, int> _monthNames = {
    "Jan" : 1,
    "Feb" : 2,
    "Mar" : 3,
    "Apr" : 4,
    "May" : 5,
    "Jun" : 6,
    "Jul" : 7,
    "Aug" : 8,
    "Sep" : 9,
    "Oct" : 10,
    "Nov" : 11,
    "Dec" : 12,
  };

  static Future< Either<ConnectionError, DateTime> > fetchDate() async {

    try {
      final url = Uri.parse('https://www.google.com/');
      final response = await head(url);

      final List<String> splitResponse = response.headers['date']!.split(' ');
      final List<int> time = splitResponse[4].split(':').map( (e) => int.parse(e) ).toList();

      DateTime date = DateTime(
        int.parse(splitResponse[3]),
        _monthNames[splitResponse[2]]!,
        int.parse(splitResponse[1]),
        time[0],
        time[1],
        time[2],
      );

      date = date.add(
        const Duration(
          hours: 2,
        )
      );
      
      return Right(date);
    }
    on SocketException catch(e) {
      debugPrint('fetchDate -> SocketException: $e');
      debugPrint(e.osError?.message);
      return const Left(
        ConnectionError(
          errorMessage: 'No Internet Connection, please try again',
        ),
      );
    }
  }
}
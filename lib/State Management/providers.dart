import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final userProvider = StreamProvider.autoDispose<User?>((ref) async* {
  User? user;
  final stream = FirebaseAuth.instance.authStateChanges();

  yield user;
});
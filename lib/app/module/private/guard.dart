import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/');

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) {
    log('guard');
    log(FirebaseAuth.instance.currentUser.toString());
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    }
    return false;
  }
}

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/credential_auth.dart';
import '../../domain/entities/credential_user.dart';
import '../../domain/exceptions/auth_failure.dart';
import 'firebase_erros.dart';
import 'google_auth.dart';

class FireBaseAuthService {
  final FirebaseAuth auth;

  FireBaseAuthService(this.auth);

  Future<bool> registerWithEmailAndPassword(CredentialAuth credential) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: credential.email, password: credential.password);
      log(result.user!.uid);
      return true;
    } on FirebaseAuthException catch (e) {
      throw RegisterAuthException(FirebaseErrors.convertMessageError(e.code));
    }
  }

  Future<CredentialUser> signInWithEmailAndPassword(
      CredentialAuth credential) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
          email: credential.email, password: credential.password);
      return CredentialUser(
          email: result.user!.email.toString(), uuid: result.user!.uid);
    } on FirebaseAuthException catch (e) {
      throw RegisterAuthException(FirebaseErrors.convertMessageError(e.code));
    }
  }

  Future<CredentialUser> socialLogin() async {
    try {
      final result = await auth
          .signInWithCredential(await GoogleAuthService.loginGoogle());
      return CredentialUser(
          email: result.user!.email.toString(), uuid: result.user!.uid);
    } on FirebaseAuthException catch (e) {
      throw RegisterAuthException(FirebaseErrors.convertMessageError(e.code));
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      throw RegisterAuthException(FirebaseErrors.convertMessageError(e.code));
    }
  }
}

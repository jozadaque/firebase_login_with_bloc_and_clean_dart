import 'package:dartz/dartz.dart';

import '../../domain/entities/credential_auth.dart';
import '../../domain/entities/credential_user.dart';

abstract class IAuthUserDatasource {
  Future<Unit> register(CredentialAuth credential);
  Future<CredentialUser> signInWithEmailAndPassword(CredentialAuth credential);
  Future<Unit> resetPasswords(String email);
  Future<CredentialUser> signInWithSocialLogin();
}

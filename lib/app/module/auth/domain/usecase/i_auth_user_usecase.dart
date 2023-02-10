import 'package:dartz/dartz.dart';
import '../entities/credential_user.dart';
import '../exceptions/auth_failure.dart';
import '../entities/credential_auth.dart';

abstract class IAuthUserUsecase {
  Future<Either<IFailureAuth, CredentialUser>> signInWithEmailAndPassword(
      CredentialAuth credential);
  Future<Either<IFailureAuth, Unit>> register(CredentialAuth credential);
  Future<Either<IFailureAuth, Unit>> resetPasswords(String email);
  Future<Either<IFailureAuth, CredentialUser>> signInWithSocialLogin();
}

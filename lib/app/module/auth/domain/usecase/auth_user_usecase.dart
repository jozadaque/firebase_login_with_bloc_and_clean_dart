import 'package:dartz/dartz.dart';
import '../entities/credential_auth.dart';
import '../entities/credential_user.dart';
import '../exceptions/auth_failure.dart';
import '../repositories/i_auth_user_repository.dart';
import '../service/validations.dart';
import 'i_auth_user_usecase.dart';

class AuthUseUsecaseImpl implements IAuthUserUsecase {
  final IAuthUseRepository repository;

  AuthUseUsecaseImpl(this.repository);

  @override
  Future<Either<IFailureAuth, Unit>> register(CredentialAuth credential) async {
    if (!ValidationsAuth.validEmail(credential.email)) {
      return left(InvalidEmail());
    }

    if (credential.password.length < 6) {
      return left(PasswordLength());
    }

    final register = await repository.register(credential);
    return register;
  }

  @override
  Future<Either<IFailureAuth, Unit>> resetPasswords(String email) async {
    if (!ValidationsAuth.validEmail(email)) {
      return left(InvalidEmail());
    }

    final resetPassword = await repository.resetPasswords(email);
    return resetPassword;
  }

  @override
  Future<Either<IFailureAuth, CredentialUser>> signInWithSocialLogin() async {
    final login = await repository.signInWithSocialLogin();
    return login;
  }

  @override
  Future<Either<IFailureAuth, CredentialUser>> signInWithEmailAndPassword(
      CredentialAuth credential) async {
    if (!ValidationsAuth.validEmail(credential.email)) {
      return left(InvalidEmail());
    }

    if (credential.password.isEmpty) {
      return left(PasswordLength());
    }

    final login = await repository.signInWithEmailAndPassword(credential);
    return login;
  }
}

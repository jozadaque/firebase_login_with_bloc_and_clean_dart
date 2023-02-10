import 'package:dartz/dartz.dart';
import '../../domain/entities/credential_auth.dart';
import '../../domain/entities/credential_user.dart';
import '../../domain/exceptions/auth_failure.dart';
import '../../domain/repositories/i_auth_user_repository.dart';
import '../datasources/i_auth_user_datasource.dart';

class AuthUseRepositoryImpl implements IAuthUseRepository {
  final IAuthUserDatasource datasource;

  AuthUseRepositoryImpl(this.datasource);

  @override
  Future<Either<IFailureAuth, Unit>> register(CredentialAuth credential) async {
    try {
      final register = await datasource.register(credential);
      return Right(register);
    } on IFailureAuth catch (e) {
      return Left(RepositoryRegisterAuthException(e.message));
    }
  }

  @override
  Future<Either<IFailureAuth, Unit>> resetPasswords(String email) async {
    try {
      final resetPassword = await datasource.resetPasswords(email);
      return Right(resetPassword);
    } on IFailureAuth catch (e) {
      return Left(RepositoryResetPasswordAuthException(e.message));
    }
  }

  @override
  Future<Either<IFailureAuth, CredentialUser>> signInWithSocialLogin() async {
    try {
      final login = await datasource.signInWithSocialLogin();
      return Right(login);
    } on IFailureAuth catch (e) {
      return Left(RepositorySocialLoginException(e.message));
    }
  }

  @override
  Future<Either<IFailureAuth, CredentialUser>> signInWithEmailAndPassword(
      CredentialAuth credential) async {
    try {
      final login = await datasource.signInWithEmailAndPassword(credential);
      return Right(login);
    } on IFailureAuth catch (e) {
      return Left(RepositorySignWithLoginAndPasswordAuthException(e.message));
    }
  }
}

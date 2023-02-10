import 'package:dartz/dartz.dart';
import '../../domain/entities/credential_auth.dart';
import '../../domain/entities/credential_user.dart';
import '../../domain/exceptions/auth_failure.dart';
import '../../infra/datasources/i_auth_user_datasource.dart';
import '../driver/firebase_auth.dart';

class AuthUserDatasourceImpl implements IAuthUserDatasource {
  final FireBaseAuthService service;

  AuthUserDatasourceImpl(this.service);

  @override
  Future<Unit> register(CredentialAuth credential) async {
    final result = await service.registerWithEmailAndPassword(credential);
    if (!result) {
      throw DatasourceRegisterAuthException();
    }

    return unit;
  }

  @override
  Future<Unit> resetPasswords(String email) async {
    final resetPassword = await service.resetPassword(email);
    if (!resetPassword) {
      throw DatasourceResetPasswordAuthException();
    }
    return unit;
  }

  @override
  Future<CredentialUser> signInWithSocialLogin() async {
    final login = await service.socialLogin();

    if (login.uuid.isEmpty) {
      throw DatasourceSocialLoginAuthException();
    }
    return login;
  }

  @override
  Future<CredentialUser> signInWithEmailAndPassword(
      CredentialAuth credential) async {
    final login = await service.signInWithEmailAndPassword(credential);
    if (login.uuid.isEmpty) {
      throw DatasourceLoginInWithEmailAndPasswordAuthException();
    }

    return login;
  }
}

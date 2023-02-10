import '../../../../domain/entities/credential_user.dart';

abstract class LoginAuthState {}

class InitialLoginAuthState extends LoginAuthState {}

class LoadingLoginAuthState extends LoginAuthState {}

class SuccessLoginAuthSate extends LoginAuthState {
  final CredentialUser user;

  SuccessLoginAuthSate(this.user);
}

class ExceptionLoginAuthState extends LoginAuthState {
  final String message;

  ExceptionLoginAuthState(this.message);
}

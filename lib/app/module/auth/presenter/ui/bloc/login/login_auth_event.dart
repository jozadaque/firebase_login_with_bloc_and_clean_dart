import '../../../../domain/entities/credential_auth.dart';

abstract class LoginAuthEvent {}

class LoginUserEvent extends LoginAuthEvent {
  final CredentialAuth credencial;

  LoginUserEvent(this.credencial);
}

class SocialLoginUserEvent extends LoginAuthEvent {}

class InitialLoginAuthEvent extends LoginAuthEvent {}

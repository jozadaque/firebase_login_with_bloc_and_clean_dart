import '../../../../domain/entities/credential_auth.dart';

abstract class RegisterAuthEvent {}

class CreateUserEvent extends RegisterAuthEvent {
  final CredentialAuth credencial;

  CreateUserEvent(this.credencial);
}

class InitialRegisterAuthEvent extends RegisterAuthEvent {}

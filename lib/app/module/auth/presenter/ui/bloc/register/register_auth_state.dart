abstract class RegisterAuthState {}

class InitialRegisterAuthState extends RegisterAuthState {}

class LoadingRegisterAuthState extends RegisterAuthState {}

class SuccessRegisterAuthSate extends RegisterAuthState {}

class ExceptionRegisterAuthState extends RegisterAuthState {
  final String message;

  ExceptionRegisterAuthState(this.message);
}

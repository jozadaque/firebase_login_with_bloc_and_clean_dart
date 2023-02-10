abstract class ResetPasswordAuthState {}

class InitialResetPasswordAuthState extends ResetPasswordAuthState {}

class LoadingResetPasswordAuthState extends ResetPasswordAuthState {}

class SuccessResetPasswordAuthSate extends ResetPasswordAuthState {}

class ExceptionResetPasswordAuthState extends ResetPasswordAuthState {
  final String message;

  ExceptionResetPasswordAuthState(this.message);
}

abstract class ResetPasswordAuthEvent {}

class ResetPasswordEvent extends ResetPasswordAuthEvent {
  final String email;

  ResetPasswordEvent(this.email);
}

class InitialResetPasswordAuthEvent extends ResetPasswordAuthEvent {}

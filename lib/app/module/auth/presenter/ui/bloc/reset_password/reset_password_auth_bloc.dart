import 'package:bloc/bloc.dart';
import '../../../../domain/usecase/i_auth_user_usecase.dart';
import 'reset_password_auth_event.dart';
import 'reset_password_auth_state.dart';

class ResetPasswordAuthBloc
    extends Bloc<ResetPasswordAuthEvent, ResetPasswordAuthState> {
  final IAuthUserUsecase usecase;

  ResetPasswordAuthBloc(this.usecase) : super(InitialResetPasswordAuthState()) {
    on(_resetPassword);
    on(_initialResetPasswordEvent);
  }

  Future<void> _initialResetPasswordEvent(
      InitialResetPasswordAuthEvent event, emit) async {
    emit(LoadingResetPasswordAuthState());
    emit(InitialResetPasswordAuthState());
  }

  Future<void> _resetPassword(ResetPasswordEvent event, emit) async {
    emit(LoadingResetPasswordAuthState());

    final resetPassword = await usecase.resetPasswords(event.email);

    resetPassword.fold(
      (l) => emit(ExceptionResetPasswordAuthState(l.message.toString())),
      (r) => emit(SuccessResetPasswordAuthSate()),
    );
  }
}

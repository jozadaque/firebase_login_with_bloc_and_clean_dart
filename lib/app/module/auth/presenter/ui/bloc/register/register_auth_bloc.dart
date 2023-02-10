import 'package:bloc/bloc.dart';
import '../../../../domain/usecase/i_auth_user_usecase.dart';
import 'register_auth_event.dart';
import 'register_auth_state.dart';

class RegisterAuthBloc extends Bloc<RegisterAuthEvent, RegisterAuthState> {
  IAuthUserUsecase usecase;

  RegisterAuthBloc(this.usecase) : super(InitialRegisterAuthState()) {
    on(_register);
    on((_initialRegisterEvent));
  }

  Future<void> _initialRegisterEvent(
      InitialRegisterAuthEvent event, emit) async {
    emit(LoadingRegisterAuthState());
    emit(InitialRegisterAuthState());
  }

  Future<void> _register(CreateUserEvent event, emit) async {
    emit(LoadingRegisterAuthState());

    final register = await usecase.register(event.credencial);

    register.fold(
      (l) => emit(ExceptionRegisterAuthState(l.message.toString())),
      (r) => emit(SuccessRegisterAuthSate()),
    );
  }
}

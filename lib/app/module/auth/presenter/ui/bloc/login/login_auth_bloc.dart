import 'package:bloc/bloc.dart';

import '../../../../domain/usecase/i_auth_user_usecase.dart';
import 'login_auth_event.dart';
import 'login_auth_state.dart';

class LoginAuthBloc extends Bloc<LoginAuthEvent, LoginAuthState> {
  IAuthUserUsecase usecase;

  LoginAuthBloc(this.usecase) : super(InitialLoginAuthState()) {
    on(_loginWithEmailAndPassword);
    on(_socialLogin);
    on((_initialLoginEvent));
  }

  Future<void> _initialLoginEvent(InitialLoginAuthEvent event, emit) async {
    emit(LoadingLoginAuthState());
    emit(InitialLoginAuthState());
  }

  Future<void> _loginWithEmailAndPassword(LoginUserEvent event, emit) async {
    emit(LoadingLoginAuthState());

    final login = await usecase.signInWithEmailAndPassword(event.credencial);

    login.fold(
      (l) => emit(ExceptionLoginAuthState(l.message.toString())),
      (r) => emit(SuccessLoginAuthSate(r)),
    );
  }

  Future<void> _socialLogin(SocialLoginUserEvent event, emit) async {
    emit(LoadingLoginAuthState());
    final login = await usecase.signInWithSocialLogin();

    login.fold(
      (l) => emit(ExceptionLoginAuthState(l.message.toString())),
      (r) => emit(SuccessLoginAuthSate(r)),
    );
  }
}
